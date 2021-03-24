//
//  AthleticsViewController.swift
//  GHSApp
//
//  Created by BY on 12/5/17.
//  Copyright © 2017 GHSAppClub. All rights reserved.
//

import UIKit

class AthleticsViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
