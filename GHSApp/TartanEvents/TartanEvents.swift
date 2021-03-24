//
//  TartanEvents.swift
//  GHSApp
//
//  Created by BY on 8/6/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//

import UIKit
import Alamofire

class TartanEvents: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet var popupView: UIView!
    @IBOutlet weak var popupDismissBtn: UIButton!
    
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var dateOfEvent: UILabel!
    
    var calendarArray = [AnyObject]()
    //var oddEvenCal = [AnyObject]()
    
    //elements taken from JSON HTTP Request
    var location : String = ""
    var event : String = ""
    var startDate : String = ""
    var endDate : String = ""
    var desc : String = ""
    var currentDate : String = ""
    
    //This determines whether to display events or dates as well as the popup for events
    //If it is false, the tableview will display dates and when clicked it will display the events tableview
    //When true, it will display events and when clicked will bring up the popupview
    var displayingEvents : Bool = false
    
    private let refreshControl = UIRefreshControl() //Pull to refresh function -> See createCalendar() for implementation
    
    let theme = ThemeManager.currentTheme()
    
    var effect: UIVisualEffect? = nil
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var key: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        key = appDelegate.GoogleAPI as String?
        
        displayingEvents = false
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //Upon loading we do not want to have the view effect until a user clicks on a calendar item
        effect = visualEffectView.effect!
        visualEffectView.effect = nil
        visualEffectView.alpha = 0
        popupView.alpha = 0
        
        //Makes the popup view rounded at edges
        popupView.layer.cornerRadius = 20
        
        self.containerView.backgroundColor = theme.secondaryColor
        self.backView.backgroundColor = theme.backgroundColor
        self.navBar.barTintColor = theme.backgroundColor
        self.tableView.backgroundColor = theme.tableColor
        self.popupView.backgroundColor = theme.backgroundColor
        self.popupDismissBtn.backgroundColor = theme.secondaryColor
        self.view.backgroundColor = theme.backgroundColor
        
        self.descTextView.isEditable = false
        self.descTextView.dataDetectorTypes = .all
        self.descTextView.delegate = self
        
        self.createCalendar()
        
        //Pull to refresh
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        //Style elements for pull refresh
        refreshControl.tintColor = theme.textColor
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing Tartan Events ...")
 
        
        //Function called is 'refreshData()' -> see below
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        //Sets height of each cell
        //It should resize using UITableViewAutomaticDimension
        //EstimatedRowHeight gives a rough area of the height as reference
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableViewAutomaticDimension

        
       // let URL = NSURL(string: "https://calendar.google.com/calendar/embed?src=benjaminyeung2012%40gmail.com&ctz=America%2FLos_Angeles")
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        key = appDelegate.GoogleAPI as String?
        self.createCalendar()
        
    }
    @IBAction func backPressed(_ sender: Any)
    {
        if(displayingEvents)
        {
            displayingEvents = false
            self.refreshData(self)
        }
        else
        {
            self.performSegue(withIdentifier: "back", sender: self)
        }
    }
    
    
    
    func animateIn()
    {
        
        print("Inside animateIn()")
        popupView.alpha = 0
        
        UIView.animate(withDuration: 0.5){
            self.visualEffectView.effect = self.effect
            self.popupView.alpha = 1
            self.visualEffectView.alpha = 1
        
        }
    }
    
    @IBAction func animateOut(_ sender: Any) {
        
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
        
        UIView.animate(withDuration: 0.1, animations: {
            self.visualEffectView.effect = nil
            self.popupView.alpha = 0
        }, completion: { (true) in
            
            UIView.animate(withDuration: 0.2, animations: {
                
                self.visualEffectView.alpha = 0
                
            })
            
        })
        
        
    }
    
    func createCalendar()
    {
        
        //TODO: Add schedules for football and band games/performances
        
        self.getTodaysDate()
        /**
         Calendars are located on the apps4ghs@gmail.com
         3mrfmud7a180r7t7j22cobdj2g@group.calendar.google.com
         This is the primary calendar used for testing:
            https://www.googleapis.com/calendar/v3/calendars/apps4ghs%40gmail.com/events?alwaysIncludeEmail=false&orderBy=startTime&singleEvents=true&fields=accessRole%2CdefaultReminders%2Cdescription%2Cetag%2Citems%2Ckind%2CnextPageToken%2CnextSyncToken%2Csummary%2CtimeZone%2Cupdated&key=" + key
         
         This is the shared calendar link (Use this one as it is updated by Granquist:
         https://www.googleapis.com/calendar/v3/calendars/3mrfmud7a180r7t7j22cobdj2g@group.calendar.google.com/events?alwaysIncludeEmail=false&maxResults=40&orderBy=startTime&singleEvents=true&fields=accessRole%2CdefaultReminders%2Cdescription%2Cetag%2Citems%2Ckind%2CnextPageToken%2CnextSyncToken%2Csummary%2CtimeZone%2Cupdated&timeMin=" + currentDate + "&key=" + key
         
         
         **/
        Alamofire.request("https://www.googleapis.com/calendar/v3/calendars/c_ldimrcomkmkae79ofpqfhf6sbk%40group.calendar.google.com/events?alwaysIncludeEmail=false&maxResults=40&orderBy=startTime&singleEvents=true&fields=accessRole%2CdefaultReminders%2Cdescription%2Cetag%2Citems%2Ckind%2CnextPageToken%2CnextSyncToken%2Csummary%2CtimeZone%2Cupdated&timeMin=" + currentDate + "&key=" + key!).responseJSON { response in
            
            if let json = response.result.value as? Dictionary<String,AnyObject>,
                let events = json["items"] {
                self.calendarArray = (events as? [AnyObject])!
            
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                
                }
            
            }
            
            
        }
    
    
    @objc private func refreshData(_ sender: Any) {
        
        self.createCalendar()
        self.refreshControl.endRefreshing() //Once createCalendar() executes endRefreshing stops the refresh animation
        
    }
    

    /** Vaulted for future use - JSON Request pings the Odd Even Calendar only created by Granquist
    func createOddEven()
    {
        Alamofire.request("https://www.googleapis.com/calendar/v3/calendars/3mrfmud7a180r7t7j22cobdj2g%40group.calendar.google.com/events?alwaysIncludeEmail=false&maxResults=40&orderBy=startTime&singleEvents=true&fields=accessRole%2CdefaultReminders%2Cdescription%2Cetag%2Citems%2Ckind%2CnextPageToken%2CnextSyncToken%2Csummary%2CtimeZone%2Cupdated&timeMin=" + currentDate + "&key=" + key).responseJSON { response in
            
            if let json = response.result.value as? Dictionary<String,AnyObject>,
                let events = json["items"] {
                self.oddEvenCal = (events as? [AnyObject])!
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
            
        }
        
    }
     **/
    
    func getTodaysDate()
    {
        let date = Date()
        let calendar = Calendar.current //Getting current date
        
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        
        var stringDay = String(day)
        var stringMonth = String(month)
        
        let stringYear = String(year)
        let stringHour = String(hour)
        let stringMinute = String(minute)
        let stringSecond = String(second)
        
        if( day < 10 ) {
            stringDay = "0" + String(day)
        }
        if (month < 10) {
            stringMonth = "0" + String(month)
        }
        
        currentDate = stringYear + "-" + stringMonth + "-" + stringDay + "T" + stringHour + "%3A" + stringMinute + "%3A" + stringSecond + "Z"
        //print(currentDate)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1;
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return calendarArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? CalendarTableViewCell
        
        if let eventDates = calendarArray[indexPath.row]["start"] as? [String:Any]
        {
            
            let startDate = eventDates["dateTime"] as? String
            let startDateNoTime = eventDates["date"] as? String
            
            var convertedDate : String = ""
            var convertedTime : String = ""
            
            //Note that .components(separatedBy: "T") makes an array that will make the first index everything before the T and the second index everything after -> splitDate and splitTime
            //JSON date is in the format "yyyy-MM-ddThh:mm:ss"
            let dateComponents = startDate?.components(separatedBy: "T")
            
            
            //Below we format the date "yyyy-MM-dd" and time "hh:mm:ss" into a more preferable format

            
            if(startDate != nil) //For some calendar events the time is not included and has a different name in JSON
            {
                let splitDate = dateComponents![0] //We use the 'T' to separate the date and the time
                let splitTime = dateComponents![1]
                
                //calendarArray = calendarArray.filter { ($0["dateTime"] ?? "") > currentDate }
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let newDateFormatter = DateFormatter()
                newDateFormatter.dateFormat = "E MMM dd"
                
                let timeFormatter = DateFormatter()
                timeFormatter.dateFormat = "HH-mm-ss"
                let newTimeFormatter = DateFormatter()
                newTimeFormatter.dateFormat = "h:mm a"
                
                if let date = dateFormatter.date(from: splitDate) {
                    convertedDate = newDateFormatter.string(from: date)
                    //print(convertedDate)
                }
                if let time = timeFormatter.date(from: splitTime) {
                    convertedTime = newTimeFormatter.string(from: time)
                    //print(convertedTime)
                }
                /** Separates Date into month and day
                let index = convertedDate.index(of: " ")
                let monthDate = convertedDate.substring(to: index!)
                let dayDate = convertedDate.substring(from: index!)
                **/
                
                let index = convertedDate.index(of: " ")
                let rangeDay = convertedDate.startIndex..<convertedDate.index(before: index!)
                let rangeMonth = index!..<convertedDate.endIndex
                let dayOfWeek = convertedDate[rangeDay]
                let monthDay = convertedDate[rangeMonth]
                
                cell?.dateLabel.text = String(monthDay)
                cell?.dayOfWeek.text = String(dayOfWeek)
                
            }
            else //If the date is not labeled under "dateTime" it is under "date"
            {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let newDateFormatter = DateFormatter()
                newDateFormatter.dateFormat = "E MMM dd"
                
                if let date = dateFormatter.date(from: startDateNoTime!) {
                    convertedDate = newDateFormatter.string(from: date)
                    //print(convertedDate)
                }
                
                /** Separates Date into month and day
                let index = convertedDate.index(of: " ")
                let monthDate = convertedDate.substring(to: index!)
                let dayDate = convertedDate.substring(from: index!)
                **/
                
                let index = convertedDate.index(of: " ")
                let rangeDay = convertedDate.startIndex..<convertedDate.index(before: index!)
                let rangeMonth = index!..<convertedDate.endIndex
                let dayOfWeek = convertedDate[rangeDay]
                let monthDay = convertedDate[rangeMonth]
                
                cell?.dateLabel.text = String(monthDay)
                cell?.dayOfWeek.text = String(dayOfWeek)
                
                
            }
            
            
            let title = calendarArray[indexPath.row]["summary"]
            cell?.eventTitle.text = title as? String
        
        cell?.eventTitle.textColor = theme.textColor
        cell?.dateLabel.textColor = theme.textColor
        cell?.dayOfWeek.textColor = theme.textColor
        cell?.backgroundColor = theme.tableColor
        cell?.dateContainer.backgroundColor = theme.tableColor
        
        
    }
        return cell!
}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Cell Clicked")
        animateIn()
        
        let title = calendarArray[indexPath.row]["summary"] as? String
        eventName.text = title
        
        let desc = calendarArray[indexPath.row]["description"] as? String
        if(desc == nil) {
            descTextView.alpha = 0
            descLabel.alpha = 0
            print("I'm here")
        } else {
            descTextView.alpha = 1
            descLabel.alpha = 1
            descTextView.text = desc
        }
        
        if let date = calendarArray[indexPath.row]["start"] as? [String:Any] {
            
            if let date2 = calendarArray[indexPath.row]["end"] as? [String:Any] {
            
            let startDate = date["dateTime"] as? String
            let startDateNoTime = date["date"] as? String
            let endDate = date2["dateTime"] as? String
            //let endDateNoTime = date2["date"] as? String
            
            var convertedDate : String = ""
            //var convertedDateEnd : String = ""
            var startTime : String = ""
            var endTime : String = ""
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let newDateFormatter = DateFormatter()
            newDateFormatter.dateFormat = "MMM dd"
            
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH-mm-ss"
            let newTimeFormatter = DateFormatter()
            newTimeFormatter.dateFormat = "h:mm a"
            
            //Note that .components(separatedBy: "T") makes an array that will make the first index everything before the T and the second index everything after -> splitDate and splitTime
            //JSON date is in the format "yyyy-MM-ddThh:mm:ss"
            let dateComponentsStart = startDate?.components(separatedBy: "T")
            let dateComponentsEnd = endDate?.components(separatedBy: "T")
            //Below we format the date "yyyy-MM-dd" and time "hh:mm:ss" into a more preferable format
            
            if(startDate != nil) //For some calendar events the time is not included and has a different name in JSON
            {
                let splitDate = dateComponentsStart![0] //We use the 'T' to separate the date and the time
                let splitTime = dateComponentsStart![1]
                let timeComponents = splitTime.components(separatedBy: "-")
                
                if let date = dateFormatter.date(from: splitDate) {
                    convertedDate = newDateFormatter.string(from: date)
                    //print(convertedDate)
                }
                if let time = timeFormatter.date(from: timeComponents[0]) {
                    startTime = newTimeFormatter.string(from: time)
                    //print(convertedTime)
                }
                
                let splitDateEnd = dateComponentsEnd![0]
                let splitTimeEnd = dateComponentsEnd![1]
                let timeComponentsEnd = splitTimeEnd.components(separatedBy: "-")
                
                if let date = dateFormatter.date(from: splitDateEnd) {
                    //convertedDateEnd = newDateFormatter.string(from: date) //This is the formatted date for the end of an event - not used in app yet
                    //print(convertedDate)
                }
                if let time = timeFormatter.date(from: timeComponentsEnd[0]) {
                    endTime = newTimeFormatter.string(from: time)
                    //print(convertedTime)
                }
                
                    dateOfEvent.text = convertedDate + " " + startTime + " - " + endTime
                
            }
            else //If the date is not labeled under "dateTime" it is under "date"
            {
                
                if let date = dateFormatter.date(from: startDateNoTime!) {
                    convertedDate = newDateFormatter.string(from: date)
                    //print(convertedDate)
                }
                
                dateOfEvent.text = convertedDate
        
            }
          }
       }
   }
        
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
            
                self.performSegue(withIdentifier: "back", sender: self)
            
        }
    }


}

extension Formatter {
    static let iso8601: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        if #available(iOS 11.0, *) {
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        } else {
            
        }
        return formatter
        }()
    }

