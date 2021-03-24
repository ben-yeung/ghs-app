 //
 //  TeacherCalendarViewController.swift
 //  GHSApp
 //
 //  Created by BY on 11/29/17.
 //  Copyright © 2017 GHSAppClub. All rights reserved.
 //
 
 import UIKit
 
 class TeacherCalendarViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet var backView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    let theme = ThemeManager.currentTheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sets the zoom scale to allow pinching
        self.view.backgroundColor = theme.backgroundColor
        self.backView.backgroundColor = theme.backgroundColor
        self.navBar.barTintColor = theme.backgroundColor
        
        ScrollView.minimumZoomScale = 1.0
        ScrollView.maximumZoomScale = 6.0
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return imageView
    }
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
            self.performSegue(withIdentifier: "back", sender: self)
        }
    }
    
 }

