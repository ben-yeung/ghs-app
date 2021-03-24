//
//  APTesting.swift
//  GHSApp
//
//  Created by BY on 4/3/19.
//  Copyright © 2019 GHSAppClub. All rights reserved.
//

import UIKit

class APTesting: UIViewController {

    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet var buttons: [UIButton]!
    
    let theme = ThemeManager.currentTheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
        
        for button in self.buttons
        {
            self.view.backgroundColor = theme.backgroundColor
            
            self.containerView.backgroundColor = theme.secondaryColor
            self.backView.backgroundColor = theme.backgroundColor
            self.navBar.barTintColor = theme.backgroundColor
            button.backgroundColor = theme.buttonColor
            self.bgImage.image = theme.themeImage
        }
        
        // Do any additional setup after loading the view.
    }
    
    //the order is Bell Schedule, Odd/Even Cal, AP Cal, AP Sessions
    
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
            self.performSegue(withIdentifier: "back", sender: self)
        }
    }
    


}
