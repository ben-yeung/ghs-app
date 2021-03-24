//
//  RegisterPage.swift
//  GHSApp
//
//  Created by BY on 9/29/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//

import UIKit
import TextFieldEffects
import Firebase

class RegisterPage: UIViewController {

    @IBOutlet var backView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var userField: HoshiTextField!
    @IBOutlet weak var emailField: HoshiTextField!
    @IBOutlet weak var passField: HoshiTextField!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var tapToChangeProfile: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var imagePicker:UIImagePickerController!
    var imageWasPicked:Bool = false
    
    let theme = ThemeManager.currentTheme()
    let animationView = LOTAnimationView(name: "loading.json")
    let animationBackground = UIView()
    
    //Array of filtered words to check in username
    //It's not so nice words, but it had to be made. Just don't look at it too long.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            self.view.backgroundColor = theme.backgroundColor
            self.containerView.backgroundColor = theme.secondaryColor
            self.backView.backgroundColor = theme.backgroundColor
            self.navBar.barTintColor = theme.backgroundColor
            self.signUpBtn.backgroundColor = theme.buttonColor
            self.imageView.image = theme.themeImageAlt
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        swipeGesture.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeGesture)
        
        let swipeGestureUp = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        swipeGesture.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeGestureUp)
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(imageTap)
        profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
        profileImageView.clipsToBounds = true
        tapToChangeProfile.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
    }
    
    func containsSwearWord(text: String, swearWords: [String]) -> Bool {
        return swearWords
            .reduce(false) { $0 || text.contains($1.lowercased()) }
    }
    

    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer)
    {
        passField.resignFirstResponder()
    }
    
    func openImagePicker()
    {
        imageWasPicked = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func signUpPress(_ sender: Any)
    {
        
        guard let username = userField.text else { return }
        //guard let email = emailField.text else { return }
        //guard let pass = passField.text else { return }
        
        let userPassed : Bool = containsSwearWord(text: username.lowercased(), swearWords: filteredWords)
        
        if(userPassed) //contains bad words
        {
            userField.text = ""
            
            let failAlert = UIAlertController(title: "Hey!!!", message: "I see you trying to create a username with some not so nice words in it. Please refrain from using these words and anything related to it. Be clean!", preferredStyle: UIAlertControllerStyle.alert)
            failAlert.addAction(UIAlertAction(title: "Oops!", style: UIAlertActionStyle.default, handler: nil))
            self.present(failAlert, animated: true, completion: nil)
        }
        else if(username.trimmingCharacters(in: .whitespacesAndNewlines) == "") //fields left blank
        {
            
            let failAlert = UIAlertController(title: "There seems to be an error", message: "Make sure that you didn't leave any fields blank!", preferredStyle: UIAlertControllerStyle.alert)
            failAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(failAlert, animated: true, completion: nil)
            
        }
        else if(username.index(of: " ") != nil)
        {
            userField.text = ""
            
            let failAlert = UIAlertController(title: "There seems to be an error", message: "Usernames should contain no spaces or special characters.", preferredStyle: UIAlertControllerStyle.alert)
            failAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(failAlert, animated: true, completion: nil)
        }
        else
        {
            
            passField.resignFirstResponder()
            
            self.animationBackground.alpha = 1
            animationView.alpha = 1
            animationView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height/2)
            animationView.center.x = self.view.center.x // for horizontal
            animationView.center.y = self.view.center.y // for vertical
            animationView.contentMode = .scaleAspectFill
            animationView.loopAnimation = true
            animationView.backgroundColor = theme.backgroundColor
            
            animationBackground.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            animationBackground.backgroundColor = theme.backgroundColor
            self.animationBackground.addSubview(animationView)
            self.view.addSubview(animationBackground)
            animationView.play()
            
            self.handleSignUp()
            
        }
    }
    
    func handleSignUp()
    {
        guard let username = userField.text else { return }
        guard let email = emailField.text else { return }
        guard let pass = passField.text else { return }
        guard let image = profileImageView.image else { return }
        
        
        //creating a new user via Firebase
        Auth.auth().createUser(withEmail: email, password: pass) { user, error in
            if error == nil && user != nil {
                print("User created!")
                
                // 1. Upload the profile image to Firebase Storage
                
                self.uploadProfilePic(image) { url in
                    
                    //Loading animation via Lottie
                    
                    
                    if url != nil {
                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                        changeRequest?.displayName = username
                        changeRequest?.photoURL = url
                        
                        changeRequest?.commitChanges { error in
                            if error == nil {
                                print("User display name changed!")
                                
                                self.saveProfileImgURL(username: username, profileImageURL: url!) { success in
                                    if success {
                                        self.animationView.stop()
                                        self.animationView.alpha = 0
                                        self.animationBackground.alpha = 0
                                        self.modalPresentationStyle = UIModalPresentationStyle.currentContext
                                        self.performSegue(withIdentifier: "registerSuccess", sender: self)
                                    }
                                }
                                
                            } else {
                                print("Error: \(error!.localizedDescription)")
                                self.animationView.stop()
                                self.animationView.alpha = 0
                                self.animationBackground.alpha = 0
                            }
                        }
                    } else {
                        // Error unable to upload profile image
                    }
                    
                }
                
            } else {
                print("Error: \(error!.localizedDescription)")
                self.animationView.stop()
                self.animationView.alpha = 0
                self.animationBackground.alpha = 0
                
                let failAlert = UIAlertController(title: "Oops!", message: "\(error!.localizedDescription)", preferredStyle: UIAlertControllerStyle.alert)
                failAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(failAlert, animated: true, completion: nil)
            }
        }

}
    
    func uploadProfilePic(_ image:UIImage, completion: @escaping ((_ url:URL?) ->()))
    {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("user/\(uid)")
        
        var imageUpload:UIImage
        
        if(!imageWasPicked)
        {
            imageUpload = UIImage(named:"whiteHollow")!
        }
        else
        {
             imageUpload = image
        }
        guard let imageData = UIImageJPEGRepresentation(imageUpload, 0.75) else { return }
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        //accessing Firebase to store images
        storageRef.putData(imageData, metadata: metaData) { metaData, error in
            if error == nil, metaData != nil {
                
                storageRef.downloadURL { url, error in
                    completion(url)
                    // success!
                }
            } else {
                // failed
                completion(nil)
            }
        }
        
    }
    
    func saveProfileImgURL(username:String, profileImageURL:URL, completion: @escaping ((_ success:Bool) ->()))
    {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        
        let userObject = [
            "username": username,
            "photoURL": profileImageURL.absoluteString
            ] as [String:Any]
        
        databaseRef.setValue(userObject) { error, ref in
            completion(error == nil)
        }
    }
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
            
            self.performSegue(withIdentifier: "back", sender: self)
            
        }
    }
  }

extension RegisterPage: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.profileImageView.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
}
