//
//  APCalendar.swift
//  GHSApp
//
//  Created by BY on 4/3/19.
//  Copyright © 2019 GHSAppClub. All rights reserved.
//

import UIKit
import WebKit

class APCalendar: UIViewController {

    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    let theme = ThemeManager.currentTheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = theme.backgroundColor
        self.containerView.backgroundColor = theme.secondaryColor
        self.backView.backgroundColor = theme.backgroundColor
        self.navBar.barTintColor = theme.backgroundColor
        self.bgImage.image = theme.themeImage
        
        showCal()
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
        
    }
    
    //the order is Bell Schedule, Odd/Even Cal, AP Cal, AP Sessions
    func showCal()
    {
        let urlS:String? = linkList[2]
        
        if let url = URL(string: urlS!) {
            let req = URLRequest(url: url)
            webView.load(req)
        }
        else {
            let failAlert = UIAlertController(title: "Something went wrong", message: "Check to see if there is a stable network connection and try again :)", preferredStyle: UIAlertControllerStyle.alert)
            failAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {action in self.performSegue(withIdentifier: "backFail", sender: self)}))
            self.present(failAlert, animated: true, completion: nil)
        }
        
    }
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
            self.performSegue(withIdentifier: "back", sender: self)
        }
    }

}

