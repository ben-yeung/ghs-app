//
//  TeacherScheduleViewController.swift
//  GHSApp
//
//  Created by BY on 11/29/17.
//  Copyright © 2017 GHSAppClub. All rights reserved.
//

import UIKit

class TeacherScheduleViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet var backView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    let theme =  ThemeManager.currentTheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Space theme image has issues with white text secondaryColor is instead used and imageView alpha is set to 0
        if(count == 2)
        {
            self.imageView.alpha = 0
        }
        else
        {
            self.imageView.alpha = 1
        }
        
        self.view.backgroundColor = theme.backgroundColor
        self.ScrollView.backgroundColor = theme.secondaryColor
        self.containerView.backgroundColor = theme.secondaryColor
        self.backView.backgroundColor = theme.backgroundColor
        self.navBar.barTintColor = theme.backgroundColor
        self.imageView.image = theme.themeImageAlt
        
        ScrollView.minimumZoomScale = 1.0
        ScrollView.maximumZoomScale = 6.0
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return containerView
    }
    
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
            self.performSegue(withIdentifier: "back", sender: self)
        }
    }
    
}
