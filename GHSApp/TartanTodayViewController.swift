//
//  TartanTodayViewController.swift
//  GHSApp
//
//  Created by BY on 12/16/17.
//  Copyright © 2017 GHSAppClub. All rights reserved.
//

import UIKit
import SafariServices

class TartanTodayViewController: UIViewController {

    
    @IBOutlet var navBar: UINavigationBar!
    @IBOutlet var backView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var bgImage: UIImageView!
    
    let theme = ThemeManager.currentTheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
        
        for button in self.buttons
        {
            self.view.backgroundColor = theme.backgroundColor
            self.scrollView.backgroundColor = theme.backgroundColor
            self.containerView.backgroundColor = theme.secondaryColor
            self.backView.backgroundColor = theme.backgroundColor
            self.navBar.barTintColor = theme.backgroundColor
            button.backgroundColor = theme.buttonColor
            self.bgImage.image = theme.themeImage
        }
    }
    
    @IBAction func instaPressed(_ sender: Any) {
        
        let instagramHooks = NSURL(string: "instagram://user?username=glendorahs")!
        if UIApplication.shared.canOpenURL(instagramHooks as URL)
        {

                UIApplication.shared.open(instagramHooks as URL)
            
        } else {
            //opens SFSafariVC because the user doesn't have Instagram
            print("App not installed")
             self.showWebsite(url: "https://www.instagram.com/glendorahs/")
        }
        
        }
    
    
    @IBAction func youPressed(_ sender: Any) {
        
        let youHooks = "youtube:///user/tartanbroadcasting13/videos"
        let youUrl = URL(string: youHooks)
        if UIApplication.shared.canOpenURL(youUrl! as URL)
        {
           
            UIApplication.shared.open(youUrl!)
            
        } else {
            //opens SFSafariVC because the user doesn't have Instagram
            print("App not installed")
            self.showWebsite(url: "https://www.youtube.com/user/tartanbroadcasting13/videos")
        }
        
        /**
        if let url = NSURL(string: "https://www.youtube.com/user/tartanbroadcasting13/videos"){
            UIApplication.shared.openURL(url as URL)
        } else {
            print("App not installed")
            self.showWebsite(url: "https://www.instagram.com/glendorahs/")
        }
        **/
    }
    
    func showWebsite(url: String)
    {
        let URL = NSURL(string: url)!
        let webVC = SFSafariViewController(url: URL as URL)
        if #available(iOS 10.0, *) {
            if(count == 0)
            {
                webVC.preferredBarTintColor = theme.backgroundColor
            }
            else if(count == 1)
            {
                webVC.preferredBarTintColor = theme.backgroundColor
            }
            else
            {
                webVC.preferredBarTintColor = theme.backgroundColor
            }
        } else {
            // Fallback on earlier versions
            UIApplication.shared.openURL(URL as URL)
            
        }
        present(webVC, animated: true, completion: nil)
    }
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
            self.performSegue(withIdentifier: "back", sender: self)
        }
    }
    
}
