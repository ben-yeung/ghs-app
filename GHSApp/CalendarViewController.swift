//
//  CalendarViewController.swift
//  GHSApp
//
//  Created by BY on 11/29/17.
//  Copyright © 2017 GHSAppClub. All rights reserved.
//

import UIKit
import Alamofire
import WebKit

var linkList = [String]()

class CalendarViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet var backView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var webView: WKWebView!
    
   
    let theme = ThemeManager.currentTheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /** Outdated --> Moving to online methods to prevent constant updating
         
        if let pdf = Bundle.main.url(forResource: "Calendar", withExtension: "pdf", subdirectory: nil, localization: nil)  {
            let req = NSURLRequest(url: pdf)
            webView.loadRequest(req as URLRequest)
        }
 
        **/
        
        showCal()
    
        self.view.backgroundColor = theme.backgroundColor
        self.backView.backgroundColor = theme.backgroundColor
        self.navBar.barTintColor = theme.backgroundColor
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
        
    }
    
    
    //This is called in StudentResources.swift so that it does not have to be called in each file. linkList is a global var and can be used in any file
    func createSearch()
    {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var key: String?
        key = appDelegate.GoogleAPI as String?
       
         linkList = []
        Alamofire.request("https://sheets.googleapis.com/v4/spreadsheets/1mjm28Lwx7D_MxcixvtzD8po7XuUHUNh-aidUuqYOopY/values/A2%3AI?key=" + key!).responseJSON { response in
            
            if let json = response.result.value as? Dictionary<String, AnyObject>,
                let response = json["values"] {
                let listedItems = (response as? [AnyObject])!
                
                var count = 0
                
                for obj in listedItems //note that listedItems contains one NSArray. This for loop is essentially accessing an array within an array
                {
                    let stringItem = obj as? [String]
                    
                    //this while loop is needed since the sheets file is setup in rows not columns. The sheets get request returns the four links in one array instead of multiple
                    while(count < 5)
                    {
                        linkList.append(stringItem![count])
                        count += 1
                    }
                    
                }
                //the order is Bell Schedule, Odd/Even Cal, AP Cal, AP Sessions, Teacher Directory
                print(linkList)
                
            }
        }
        
    }
    
    func showCal()
    {
        
       let urlS:String? = linkList[1]
        
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
    
    /** Not being used. Sharing capability at the local level
    @IBAction func sharePressed(_ sender: Any) {
        
        let pdf = Bundle.main.url(forResource: "Calendar", withExtension: "pdf", subdirectory: nil, localization: nil)
        
        if UIDevice.current.userInterfaceIdiom == .pad //the iPad uses a different type of sharing and crashes when using UIActivityViewController
        {
           
            let activityVC = UIActivityViewController(activityItems: [pdf], applicationActivities: nil)
            activityVC.title = "Share"
            activityVC.excludedActivityTypes = []
            
            activityVC.popoverPresentationController?.sourceView = self.view
            activityVC.popoverPresentationController?.barButtonItem = shareBtn
            
            self.present(activityVC, animated: true, completion: nil)
        }
        else
        {
            let shareVC = UIActivityViewController(activityItems: [pdf], applicationActivities: [])
            present(shareVC, animated: true)
            
        }
        
    }
    **/
    
    //allows for one swift file but multiple entries
    @IBAction func backPress(_ sender: Any) {
        
        if(fromTeacher)
        {
            self.performSegue(withIdentifier: "backTeacher", sender: self)
        } else {
            self.performSegue(withIdentifier: "backStudent", sender: self)
        }
        
    }
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
            if(fromTeacher)
            {
                self.performSegue(withIdentifier: "backTeacher", sender: self)
            } else {
                self.performSegue(withIdentifier: "backStudent", sender: self)
            }
        }
    }

}
