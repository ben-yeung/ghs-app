//
//  LoginPage.swift
//  GHSApp
//
//  Created by BY on 9/27/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//


 
import UIKit
import TextFieldEffects
import Firebase
import Lottie

var userAuth = Bool()

class LoginPage: UIViewController {

    @IBOutlet var backView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var buttons: [UIButton]!
        
    @IBOutlet weak var emailField: HoshiTextField!
    @IBOutlet weak var passField: HoshiTextField!
    
    let theme = ThemeManager.currentTheme()
    let animationView = LOTAnimationView(name: "loading.json")
    let animationBackground = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in self.buttons
        {
            self.view.backgroundColor = theme.backgroundColor
            self.containerView.backgroundColor = theme.secondaryColor
            self.backView.backgroundColor = theme.backgroundColor
            self.navBar.barTintColor = theme.backgroundColor
            button.backgroundColor = theme.buttonColor
            self.imageView.image = theme.themeImageAlt
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        swipeGesture.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeGesture)
        
        let swipeGestureUp = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        swipeGesture.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeGestureUp)
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        
        guard let email = emailField.text else { return }
        guard let pass = passField.text else { return }
        
        if(email.trimmingCharacters(in: .whitespacesAndNewlines) != "" || pass.trimmingCharacters(in: .whitespacesAndNewlines) != "" ) {
            
            passField.resignFirstResponder()
            
            animationView.alpha = 1
            animationBackground.alpha = 1
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
            
            self.handleSignIn()
            
        } else {
            
            let failAlert = UIAlertController(title: "There seems to be an error", message: "Make sure that you didn't leave any fields blank!", preferredStyle: UIAlertControllerStyle.alert)
            failAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(failAlert, animated: true, completion: nil)
            
        }
        
    }
    
    func handleSignIn()
    {
        guard let email = emailField.text else { return }
        guard let pass = passField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: pass) { user, error in
            if error == nil && user != nil
            {
                print("Sign in successful")
                userAuth = true
                
                self.animationView.stop()
                self.animationView.alpha = 0
                self.animationBackground.alpha = 0
                self.performSegue(withIdentifier: "authSuccess", sender: self)
            }
            else
            {
                print("Error: \(error!.localizedDescription)")
                
                if(error!.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted.")
                {
                    self.animationView.stop()
                    self.animationView.alpha = 0
                    self.animationBackground.alpha = 0
                    
                    self.emailField.text = ""
                    self.passField.text = ""
                    
                    let failAlert = UIAlertController(title: "Oops!", message: "The account you're trying to access does not appear to be on our list. Please double check your entries or register a new account!", preferredStyle: UIAlertControllerStyle.alert)
                    failAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(failAlert, animated: true, completion: nil)
                } else {
                    self.animationView.stop()
                    self.animationView.alpha = 0
                    self.animationBackground.alpha = 0
                    
                    self.emailField.text = ""
                    self.passField.text = ""
                    
                    let failAlert = UIAlertController(title: "Oops!", message: "\(error!.localizedDescription)", preferredStyle: UIAlertControllerStyle.alert)
                    failAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(failAlert, animated: true, completion: nil)
                }
                
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let user = Auth.auth().currentUser
        {
            self.performSegue(withIdentifier: "authSuccess", sender: self)
            
        }
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer)
    {
        passField.resignFirstResponder()
    }
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")

                self.performSegue(withIdentifier: "back", sender: self)
            
        }
    }

}

