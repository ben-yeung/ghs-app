//
//  Announcements.swift
//  GHSApp
//
//  Created by BY on 2/3/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//

import UIKit
import TwitterKit
import SwiftyJSON
import UserNotifications
import TwitterCore
import Firebase
import FirebaseMessaging

var numTweets = Int()


class Twitter: TWTRTimelineViewController, TWTRTweetViewDelegate {

    
   // @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var backView: UITableView!
    
    let theme = ThemeManager.currentTheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //numTweets = Int(self.countOfTweets())
        self.view.backgroundColor = theme.backgroundColor
        self.containerView.backgroundColor = theme.secondaryColor
        self.backView.backgroundColor = theme.backgroundColor
        self.navBar.barTintColor = theme.backgroundColor

        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
        
        
        self.dataSource = TWTRUserTimelineDataSource(screenName: "glendorahs_asb", apiClient: TWTRAPIClient())
        self.showTweetActions = true
 
 
    }
    
    @IBAction func backPressed(_ sender: Any) {
        
        if(fromTeacher)
        {
            self.performSegue(withIdentifier: "backTeacher", sender: self)
        } else {
            self.performSegue(withIdentifier: "backStudent", sender: self)
        }
        
    }
    
/* Testing with a Segment Control
    @IBAction func switchPressed(_ sender: Any)
    {
        
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            self.dataSource = TWTRUserTimelineDataSource(screenName: "GlendoraHigh", apiClient: TWTRAPIClient())
            self.refresh()
        case 1:
            self.dataSource = TWTRUserTimelineDataSource(screenName: "realDonaldTrump", apiClient: TWTRAPIClient())
            self.refresh()
            
        default:
            break
        }
        
    }
 */
    
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




