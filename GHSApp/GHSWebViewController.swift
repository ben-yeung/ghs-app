//
//  GHSWebViewController.swift
//  GHSApp
//
//  Created by BY on 11/23/17.
//  Copyright © 2017 GHSAppClub. All rights reserved.
//

import UIKit

class GHSWebViewController: UIViewController {

    @IBOutlet weak var WebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //make sure to keep https:// for format or web wont load
        let URL = NSURL(string: "https://www.glendorahigh.net/")
        
        WebView.loadRequest(NSURLRequest(url: URL! as URL) as URLRequest)
        
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
