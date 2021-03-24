//
//  AbsencePolicyViewController.swift
//  GHSApp
//
//  Created by BY on 7/29/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//

import UIKit
import WebKit

class AbsencePolicyViewController: UIViewController {

    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var backView: UIView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var webView: WKWebView!
    
    let theme = ThemeManager.currentTheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = theme.backgroundColor
        self.containerView.backgroundColor = theme.secondaryColor
        self.backView.backgroundColor = theme.backgroundColor
        self.navBar.barTintColor = theme.backgroundColor
        
        if let pdf = Bundle.main.url(forResource: "AbsencePolicy", withExtension: "pdf", subdirectory: nil, localization: nil)  {
            let req = NSURLRequest(url: pdf)
            webView.load(req as URLRequest)
        }
        
        
        // Do any additional setup after loading the view.
    }


}
