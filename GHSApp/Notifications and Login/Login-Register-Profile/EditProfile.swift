//
//  EditProfile.swift
//  GHSApp
//
//  Created by BY on 9/30/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//

import UIKit
import Firebase

class EditProfile: UIViewController {

    @IBOutlet var backView: UIView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var tapToChange: UIButton!
    
    let theme = ThemeManager.currentTheme()
    let animationView = LOTAnimationView(name: "loading.json")
    let animationBackground = UIView()
    var imagePicker:UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = Auth.auth().currentUser
        if let user = user {
            let photoURL = user.photoURL
            
            if(photoURL != nil)
            {
                ImageService.getImage(withURL: photoURL!) { image in
                    self.profilePic.image = image
                }
                
            } else {
        
                self.profilePic.image = UIImage(named: "profilePic")
                
            }
            
            
        }
        
        self.view.backgroundColor = theme.backgroundColor
        self.containerView.backgroundColor = theme.secondaryColor
        self.backView.backgroundColor = theme.backgroundColor
        self.navBar.barTintColor = theme.backgroundColor
        self.updateBtn.backgroundColor = theme.buttonColor
        self.imageView.image = theme.themeImageAlt
        // Do any additional setup after loading the view.
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        profilePic.isUserInteractionEnabled = true
        profilePic.addGestureRecognizer(imageTap)
        profilePic.layer.cornerRadius = profilePic.bounds.height / 2
        profilePic.clipsToBounds = true
        tapToChange.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
    }
    
    func openImagePicker()
    {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func updatePressed(_ sender: Any) {
        
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
        
        let user = Auth.auth().currentUser
        
        guard let image = profilePic.image else { return }
        guard let username = user?.displayName else { return }
            
        self.uploadProfilePic(image) { url in
            
            if url != nil {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.photoURL = url
                
                changeRequest?.commitChanges { error in
                    if error == nil {
                        
                        self.saveProfileImgURL(username: username, profileImageURL: url!) { success in
                            if success {
                                self.animationView.stop()
                                self.animationView.alpha = 0
                                self.animationBackground.alpha = 0
                                self.dismiss(animated: true, completion: nil)
                            }
                        }
                        
                    } else {
                        print("Error: \(error!.localizedDescription)")
                    }
                }
            } else {
                // Error unable to upload profile image
            }
            
        }
        
    }
    
    func uploadProfilePic(_ image:UIImage, completion: @escaping ((_ url:URL?) ->()))
    {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("user/\(uid)")
        
        guard let imageData = UIImageJPEGRepresentation(image, 0.75) else { return }
        
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
}

extension EditProfile: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.profilePic.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
}
