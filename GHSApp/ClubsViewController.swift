//
//  ClubsViewController.swift
//  GHSApp
//
//  Created by BY on 4/3/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//

import UIKit

class ClubsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //make sure to keep https:// for format
        //NOTE: campuswoohoo as of April 2018 is not https and cannot be used as it does not conform to security policy
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
            self.performSegue(withIdentifier: "back", sender: self)
        }
        
    }

}
