//
//  AccountPage.swift
//  GHSApp
//
//  Created by BY on 9/30/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//

import UIKit
import Firebase

class AccountPage: UIViewController {

    @IBOutlet var backView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var logoutBtn: UIButton!
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    let theme = ThemeManager.currentTheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePic.layer.cornerRadius = profilePic.bounds.height / 2
        profilePic.clipsToBounds = true
        
        self.loadData() //Loads profile pic, email, and username
        
        self.view.backgroundColor = theme.backgroundColor
        self.containerView.backgroundColor = theme.secondaryColor
        self.backView.backgroundColor = theme.backgroundColor
        self.navBar.barTintColor = theme.backgroundColor
        self.logoutBtn.backgroundColor = theme.buttonColor
        self.imageView.image = theme.themeImageAlt
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
        
        // Do any additional setup after loading the view.
    }
    
    func loadData()
    {
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            let email = user.email
            let photoURL = user.photoURL
            let username = user.displayName
            print(username)
            print(photoURL)
            print(email)
            
            if(photoURL != nil)
            {
                self.userLabel.text = username
                self.emailLabel.text = email
                
                ImageService.getImage(withURL: photoURL!) { image in
                    self.profilePic.image = image
                }
                
            } else {
                
                self.userLabel.text = username
                self.emailLabel.text = email
                self.profilePic.image = UIImage(named: "profilePic")
                
            }
            
            
        }
    }
    @IBAction func logoutPressed(_ sender: Any) {
        
        try! Auth.auth().signOut()
        userAuth = false
        
        self.performSegue(withIdentifier: "back", sender: self)
        
    }
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
            
            self.performSegue(withIdentifier: "back", sender: self)
            
        }
    }
    
}
