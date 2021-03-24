//
//  Notifications.swift
//  GHSApp
//
//  Created by BY on 9/27/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//

import UIKit
import Alamofire
import SafariServices

class Notifications: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var notifTitle: UILabel!
    @IBOutlet weak var notifDesc: UITextView!
    @IBOutlet weak var linkBtn: UIButton!
    @IBOutlet weak var popupDismissBtn: UIButton!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    let theme = ThemeManager.currentTheme()
    var notifList = [AnyObject]()
    private let refreshControl = UIRefreshControl()
    
    var effect:UIVisualEffect? = nil
    var link:String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        effect = visualEffectView.effect!
        visualEffectView.effect = nil
        visualEffectView.alpha = 0
        popUpView.alpha = 0
        popUpView.layer.cornerRadius = 20
        
        self.containerView.backgroundColor = theme.secondaryColor
        self.backView.backgroundColor = theme.backgroundColor
        self.navBar.barTintColor = theme.backgroundColor
        self.tableView.backgroundColor = theme.tableColor
        self.popUpView.backgroundColor = theme.backgroundColor
        self.popupDismissBtn.backgroundColor = theme.secondaryColor
        self.linkBtn.backgroundColor = theme.secondaryColor
        self.view.backgroundColor = theme.backgroundColor
        
        //Style elements for pull refresh
        refreshControl.tintColor = theme.textColor
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing Notifications ...")
        
        //Function called is 'refreshData()' -> see below
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        //Sets height of each cell
        //It should resize using UITableViewAutomaticDimension
        //EstimatedRowHeight gives a rough area of the height as reference
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.loadNotifications()
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)

        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.loadNotifications()
        
    }
    
    func animateIn()
    {
        
        print("Inside animateIn()")
        popUpView.alpha = 0
        
        UIView.animate(withDuration: 0.5){
            self.visualEffectView.effect = self.effect
            self.popUpView.alpha = 1
            self.visualEffectView.alpha = 1
            
        }
    }
    
    @IBAction func animateOut(_ sender: Any) {
        
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
        
        UIView.animate(withDuration: 0.1, animations: {
            self.visualEffectView.effect = nil
            self.popUpView.alpha = 0
        }, completion: { (true) in
            
            UIView.animate(withDuration: 0.2, animations: {
                
                self.visualEffectView.alpha = 0
                
            })
            
        })
        
        
    }
    
    @IBAction func linkPress(_ sender: Any) {
        
        self.showWebsite(url: link!)
        
    }
    
    @objc private func refreshData(_ sender: Any) {
        
        self.loadNotifications()
        self.refreshControl.endRefreshing() //Once createCalendar() executes endRefreshing stops the refresh animation
        
    }
    
    func loadNotifications()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var key: String?
        key = appDelegate.GoogleAPI as String?
        Alamofire.request("https://sheets.googleapis.com/v4/spreadsheets/1xnNAhN1LW0X7CQCEYuSQB4cf5bb2-3ep-iOUV7qQYWI/values/A2:D?key=" + key!).responseJSON { response in
            
            if let json = response.result.value as? Dictionary<String, AnyObject>,
                let notifs = json["values"] {
                
                self.notifList = (notifs as? [AnyObject])!
                self.notifList.reverse()
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1;
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return notifList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notifCell", for: indexPath) as? NotificationCell
       
         //The order is as follows for the notifArray [date, title, message, link]
         let notifArray = notifList[indexPath.row] as? [String]
            //print(notifArray)
        
            let notifDate = notifArray![0]
            var convertedDate : String = ""
            
            let dateComponents = notifDate.components(separatedBy: " ")
            let splitDate = dateComponents[0] //We use the 'T' to separate the date and the time
            
            //calendarArray = calendarArray.filter { ($0["dateTime"] ?? "") > currentDate }
            //Note that for notifications we prob aren't using time
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let newDateFormatter = DateFormatter()
            newDateFormatter.dateFormat = "MMM dd"
            
            if let date = dateFormatter.date(from: splitDate) {
                convertedDate = newDateFormatter.string(from: date)
                //print(convertedDate)
            }
        
        let index = convertedDate.index(of: " ")
        let month = convertedDate.substring(to: index!)
        let day = convertedDate.substring(from: index!)
        
        cell?.month.text = month
        cell?.day.text = day
        cell?.notificationText.text = notifArray![1]
        cell?.notificationText.centerVertically()
        cell?.backgroundColor = theme.tableColor
        cell?.dateContainer.backgroundColor = theme.tableColor
        cell?.month.textColor = theme.textColor
        cell?.day.textColor = theme.textColor
        cell?.notificationText.textColor = theme.textColor
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        animateIn()
        
        let notifArray = notifList[indexPath.row] as? [String]
            self.notifTitle.text = notifArray![1]
            self.notifDesc.text = notifArray![2]
        
            //If notif does not supply link, check if the array size of notif is == 3 rather than 4
            //If notifArray is size 4 there is a link, if not there is no link so hide link Btn
        
            if(notifArray?.count == 3)
            {
                self.linkBtn.alpha = 0
            }
            else
            {
                self.linkBtn.alpha = 1
                self.link = notifArray![3]
            }
    }
    
    /**
     Using SFSafariViewController (Alternative to WebView)
     **/
    func showWebsite(url: String)
    {
        let URL = NSURL(string: url)!
        let webVC = SFSafariViewController(url: URL as URL)
        if #available(iOS 10.0, *) {
    
            webVC.preferredBarTintColor = theme.backgroundColor
            webVC.preferredControlTintColor = UIColor.white
            
        } else {
            // Fallback on earlier versions
        }
        present(webVC, animated: true, completion: nil)
    }
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
        
                self.performSegue(withIdentifier: "back", sender: self)
            
        }
    }

}

