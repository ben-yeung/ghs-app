//
//  ScheduleViewController.swift
//  GHSApp
//
//  Created by BY on 11/29/17.
//  Copyright © 2017 GHSAppClub. All rights reserved.
//

import UIKit
import WebKit
class ScheduleViewController: UIViewController, UIScrollViewDelegate {
 
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet var backView: UIView!
    @IBOutlet weak var webView: WKWebView!
    
    
    let theme =  ThemeManager.currentTheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = theme.backgroundColor
        self.backView.backgroundColor = theme.backgroundColor
        self.navBar.barTintColor = theme.backgroundColor
        
        
        showSchedule()
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
        
    }
    
    //the order is Bell Schedule, Odd/Even Cal, AP Cal, AP Sessions, Teacher Directory
    func showSchedule()
    {
        //linkList is a global var that holds links to the relevant destinations
        let urlS:String? = linkList[0]
        
        if let url = URL(string: urlS!) {
            let req = URLRequest(url: url)
            webView.load(req)
        }
        else { //Trying to see if a "if let" statement would catch the URLRequest unwrapping nil
            let failAlert = UIAlertController(title: "Something went wrong", message: "Check to see if there is a stable network connection and try again :)", preferredStyle: UIAlertControllerStyle.alert)
            failAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {action in self.performSegue(withIdentifier: "backFail", sender: self)}))
            self.present(failAlert, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func backPress(_ sender: Any) {
        
        if(fromTeacher)
        {
            self.performSegue(withIdentifier: "backTeacher", sender: self)
        } else{
            self.performSegue(withIdentifier: "backStudent", sender: self)
        }
    }
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
            if(fromTeacher)
            {
                self.performSegue(withIdentifier: "backTeacher", sender: self)
            } else{
                self.performSegue(withIdentifier: "backStudent", sender: self)
            }
        }
    }

}

