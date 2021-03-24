//
//  ContactGHSViewController.swift
//  GHSApp
//
//  Created by BY on 4/3/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//

import UIKit
import SafariServices

class ContactGHSViewController: UIViewController {

    
    @IBOutlet var navBar: UINavigationBar!
    @IBOutlet var backView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var shade: UIView!
    @IBOutlet weak var absenceBtn: UIButton!
    
    let theme = ThemeManager.currentTheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
        
        self.view.backgroundColor = theme.backgroundColor
        self.containerView.backgroundColor = theme.secondaryColor
        self.backView.backgroundColor = theme.backgroundColor
        self.navBar.barTintColor = theme.backgroundColor
        self.imageView.image = theme.themeImageAlt
        
    }

    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
            self.performSegue(withIdentifier: "back", sender: self)
        }
    }
    
    @IBAction func websiteTap(_ sender: Any) {
        self.showWebsite(url: "http://glendorahigh.net")
    }
    
    @IBAction func absenceTap(_ sender: Any) {
        self.showWebsite(url: "https://docs.google.com/forms/d/1_P37i-pMGQyj7QBPra4GRqlKM8T55lstL6RB594w1Jo/viewform?edit_requested=true")
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
        }
        present(webVC, animated: true, completion: nil)
    }
    
}
