//
//  StudentResources.swift
//  GHSApp
//
//  Created by BY on 11/11/17.
//  Copyright © 2017 GHSAppClub. All rights reserved.
//

import UIKit
import SafariServices

class StudentResources: UIViewController {


   
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var navBar: UINavigationBar!
    @IBOutlet var backView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var containerView: UIView!
    
    let theme = ThemeManager.currentTheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(count)
        
        scrollView.isDirectionalLockEnabled = true
        scrollView.alwaysBounceVertical = true
        
        
        for button in self.buttons
        {
            self.view.backgroundColor = theme.backgroundColor
            self.scrollView.backgroundColor = theme.secondaryColor
            self.containerView.backgroundColor = theme.secondaryColor
            self.backView.backgroundColor = theme.backgroundColor
            self.navBar.barTintColor = theme.backgroundColor
            button.backgroundColor = theme.buttonColor
            self.imageView.image = theme.themeImage
            //button.setBackgroundImage(theme.btnBG, for: UIControlState.normal)
        }
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
    }
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
            self.performSegue(withIdentifier: "back", sender: self)
        }
    }
    @IBAction func classroom(_ sender: Any) {
        
        let classHooks = "googleclassroom://www.classroom.google.com/u/0/h"
        let classUrl = URL(string: classHooks)
        if UIApplication.shared.canOpenURL(classUrl! as URL)
        {
            
            UIApplication.shared.open(classUrl!)
            
        } else {
            //opens SFSafariVC because the user doesn't have Instagram
            print("App not installed")
            self.showWebsite(url: "https://classroom.google.com/u/0/h")
        }
    }
    
    @IBAction func schedulePress(_ sender: Any) {
        fromTeacher = false
    }
    
    @IBAction func mapPress(_ sender: Any) {
        fromTeacher = false
    }
    
    @IBAction func calendarPress(_ sender: Any) {
        fromTeacher = false
    }
    
    /**
     Using SFSafariViewController (Alternative to WebView)
     **/
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
    
    @IBAction func aeriesTap(_ sender: Any)
    {
        self.showWebsite(url: "https://aeries.glendora.k12.ca.us/ParentPortal/LoginParent.aspx?page=default.aspx")
    }
    
    @IBAction func turnitinTap(_ sender: Any)
    {
        self.showWebsite(url: "https://www.turnitin.com/login_page.asp?lang=en_us")
    }
    
    @IBAction func announceTap(_ sender: Any)
    {
        self.showWebsite(url: "https://goo.gl/forms/J95VfIr89Lnj2QpY2")
    }
    
    @IBAction func navianceTap(_ sender: Any)
    {
        self.showWebsite(url: "https://connection.naviance.com/family-connection/auth/login/?hsid=glen")
    }
    
    @IBAction func athleticTap(_ sender: Any)
    {
        self.showWebsite(url: "https://glendoraathletics.com/events")
    }
    
    @IBAction func bandTap(_ sender: Any)
    {
        self.showWebsite(url: "https://www.leaguelineup.com/calendar.asp?url=ghstartanband")
    }
    
    @IBAction func tutorTap(_ sender: Any)
    {
        self.showWebsite(url: "https://lhh.tutor.com/?ProgramGUID=0dfda8cc-9f9e-4c9f-b88a-5b337887fdff")
    }
    
    @IBAction func storeTap(_ sender: Any)
    {
        self.showWebsite(url: "https://glendorahighschool.myschoolcentral.com/asbworks/(S(pu4i0x25m52p5oduhuqljuvr))/apps/webstore/pages/WebStore.aspx?org=9701")
    }
    
    @IBAction func yearbookTap(_ sender: Any) {
        self.showWebsite(url: "https://sites.google.com/view/glendorayearbook/home")
    }
    
    
}




