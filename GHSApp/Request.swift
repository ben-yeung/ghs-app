//
//  Request.swift
//  GHSApp
//
//  Created by BY on 1/31/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//

import UIKit

class Request: UIViewController {

    @IBOutlet weak var WebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //make sure to keep http:// for format
        let URL = NSURL(string: "https://goo.gl/forms/J95VfIr89Lnj2QpY2") //need to make google form for request
        
        WebView.loadRequest(NSURLRequest(url: URL! as URL) as URLRequest)
        
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
