//
//  AESOP.swift
//  GHSApp
//
//  Created by BY on 1/31/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//

import UIKit

class AESOP: UIViewController {

    @IBOutlet weak var WebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //make sure to keep http:// for format
        let URL = NSURL(string: "https://login.frontlineeducation.com/login?signin=e99f05d5f985b7877fcb174ab919f673&productId=ABSMGMT&clientId=ABSMGMT#/login")
        
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
