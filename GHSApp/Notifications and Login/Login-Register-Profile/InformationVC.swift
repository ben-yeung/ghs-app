//
//  InformationVC.swift
//  GHSApp
//
//  Created by BY on 9/29/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//\
import UIKit

class InformationVC: UIViewController {

    @IBOutlet var backView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    let theme = ThemeManager.currentTheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()

            self.view.backgroundColor = theme.backgroundColor
            self.containerView.backgroundColor = theme.secondaryColor
            self.backView.backgroundColor = theme.backgroundColor
            self.navBar.barTintColor = theme.backgroundColor
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
