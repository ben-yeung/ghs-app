//
//  AeriesViewController.swift
//  GHSApp
//
//  Created by BY on 11/22/17.
//  Copyright © 2017 GHSAppClub. All rights reserved.
//

import UIKit

class AeriesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

