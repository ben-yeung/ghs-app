//
//  TeacherResources.swift
//  GHSApp
//
//  Created by BY on 1/31/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//

import UIKit
import SafariServices

var fromTeacher = true

class TeacherResources: UIViewController {

        @IBOutlet weak var scrollView: UIScrollView!
        @IBOutlet var buttons: [UIButton]!
        @IBOutlet var navBar: UINavigationBar!
        @IBOutlet var backView: UIView!
        @IBOutlet var imageView: UIImageView!
        @IBOutlet var containerView: UIView!
        @IBOutlet var bgView: UIView!
    
        let theme = ThemeManager.currentTheme()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            scrollView.isDirectionalLockEnabled = true
            scrollView.alwaysBounceVertical = true
            
            for button in self.buttons
            {
                self.view.backgroundColor = theme.backgroundColor
                self.scrollView.backgroundColor = theme.secondaryColor
                self.bgView.backgroundColor = theme.secondaryColor
                self.backView.backgroundColor = theme.backgroundColor
                self.navBar.barTintColor = theme.backgroundColor
                button.backgroundColor = theme.buttonColor
                self.imageView.image = theme.themeImage
            }
            
            
            let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
            edgePan.edges = .left
            view.addGestureRecognizer(edgePan)
            // Do any additional setup after loading the view.
    }
    
    @IBAction func twitterPress(_ sender: Any) {
        
        fromTeacher = true
        self.performSegue(withIdentifier: "twitterTeacher", sender: self)
        
    }
    
    @IBAction func mapPress(_ sender: Any) {
        
        fromTeacher = true
        self.performSegue(withIdentifier: "mapTeacher", sender: self)
        
    }
    
    @IBAction func calendarPress(_ sender: Any) {
        
        fromTeacher = true
        self.performSegue(withIdentifier: "calendarTeacher", sender: self)
        
    }
    
    @IBAction func schedulePress(_ sender: Any) {
        
        fromTeacher = true
        self.performSegue(withIdentifier: "scheduleTeacher", sender: self)
    }
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
            self.performSegue(withIdentifier: "back", sender: self)
        }
    }
    
    func showWebsite(url: String)
    {
        let URL = NSURL(string: url)!
        let webVC = SFSafariViewController(url: URL as URL)
        if #available(iOS 10.0, *) {
            
            webVC.preferredBarTintColor = theme.backgroundColor
            webVC.preferredControlTintColor = UIColor.white
            
        } else {
            // Fallback on earlier versions
        }
        present(webVC, animated: true, completion: nil)
    }
    
    @IBAction func aeriesTap(_ sender: Any) {
        
        self.showWebsite(url: "https://aeries.glendora.k12.ca.us/Aeries.NET/Login.aspx?page=default.aspx")
        
    }
    
    @IBAction func aesopTap(_ sender: Any) {
        
        self.showWebsite(url: "https://login.frontlineeducation.com/login?signin=e99f05d5f985b7877fcb174ab919f673&productId=ABSMGMT&clientId=ABSMGMT#/login")
        
    }
    
    @IBAction func districtTap(_ sender: Any) {
        
        self.showWebsite(url: "https://www.glendora.k12.ca.us/")
        
    }
    
    @IBAction func announcementTap(_ sender: Any) {
        
        self.showWebsite(url: "https://goo.gl/forms/J95VfIr89Lnj2QpY2")
        
    }
    
    
    
    
    }


