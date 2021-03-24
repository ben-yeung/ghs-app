//
//  AugmentedReality.swift
//  GHSApp
//
//  Created by BY on 10/1/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//

import UIKit
import ARKit
import Lottie

class AugmentedReality: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet var backView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    
    let theme = ThemeManager.currentTheme()
    let animationView = LOTAnimationView(name: "secret.json")
    let animationBackground = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = theme.backgroundColor
        self.containerView.backgroundColor = theme.secondaryColor
        self.backView.backgroundColor = theme.backgroundColor
        self.navBar.barTintColor = theme.backgroundColor
        
        self.animationBackground.alpha = 1
        animationView.alpha = 1
        animationView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        animationView.center.x = self.view.center.x // for horizontal
        animationView.center.y = self.view.center.y // for vertical
        animationView.contentMode = .scaleAspectFill
        animationView.loopAnimation = true
        animationView.backgroundColor = theme.secondaryColor
        
        animationBackground.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        animationBackground.backgroundColor = theme.secondaryColor
        self.animationBackground.addSubview(animationView)
        self.containerView.addSubview(animationBackground)
        animationView.play()
        
        /** AR KIT STUFF TODO **/
        if #available(iOS 11.0, *) {
            let sceneView = ARSCNView(frame: view.bounds)
            //sceneView.scene = // ... set up your SceneKit scene ...
            //self.containerView.addSubview(sceneView)
        } else {
            // Fallback on earlier versions
            let failAlert = UIAlertController(title: "There seems to be an error", message: "AR is not supported for devices with iOS versions lower than iOS 11", preferredStyle: UIAlertControllerStyle.alert)
            failAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                self.performSegue(withIdentifier: "back", sender: self)
            }))
            self.present(failAlert, animated: true, completion: nil)
            
        }
        
        
    }
    

}
