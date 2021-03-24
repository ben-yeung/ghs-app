//
//  AboutViewController.swift
//  GHSApp
//
//  Created by BY on 11/23/17.
//  Copyright © 2017 GHSAppClub. All rights reserved.
//

import UIKit
import MessageUI

class AboutViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet var navBar: UINavigationBar!
    @IBOutlet var backView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var button: UIButton!
    
    let theme = ThemeManager.currentTheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.backgroundColor = theme.backgroundColor
        self.containerView.backgroundColor = theme.secondaryColor
        self.backView.backgroundColor = theme.backgroundColor
        self.navBar.barTintColor = theme.backgroundColor
        button.backgroundColor = theme.buttonColor
        self.imageView.image = theme.themeImageAlt
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)

    }
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
            self.performSegue(withIdentifier: "back", sender: self)
        }
    }
    
}
