//
//  TeacherViewController.swift
//  GHSApp
//
//  Created by BY on 1/10/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//

import UIKit
import SearchTextField
import Alamofire

var teacherNames = [String]()
var teacherName = String() //testing global string for JSON

class TeacherViewController: UIViewController {


    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet var backView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var teacherTextField: SearchTextField!
    
    
    let theme = ThemeManager.currentTheme()
    
    var teacherList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teacherList = []
        createTeacherList()
        //print(teacherList)
        
        for button in self.buttons
        {
            self.view.backgroundColor = theme.backgroundColor
            self.containerView.backgroundColor = theme.secondaryColor
            self.backView.backgroundColor = theme.backgroundColor
            self.navBar.barTintColor = theme.backgroundColor
            button.backgroundColor = theme.buttonColor
            self.imageView.image = theme.themeImageAlt
        }
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        swipeGesture.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeGesture)
        
        let swipeGestureUp = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        swipeGesture.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeGestureUp)
        
       
    }
    
    func createTeacherList()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var key: String?
        key = appDelegate.GoogleAPI as String?
        Alamofire.request("https://sheets.googleapis.com/v4/spreadsheets/12MnypDjkhaQpYZxSXX5QuL0_dry23Udmcn5FDlYSh84/values/I2%3AI?key=" + key!).responseJSON { response in
            
            if let json = response.result.value as? Dictionary<String, AnyObject>,
                let names = json["values"] {
                let teachersNamed = (names as? [AnyObject])!
                
                for teacher in teachersNamed
                {
                    let stringTeacher = teacher as? [String]
                    self.teacherList.append(stringTeacher![0])
                }
                
                print(self.teacherList)
                self.setupAutocomplete()
            }
            
        }
    }
    
    func setupAutocomplete()
    {
        
        teacherTextField.filterStrings(teacherList)
        
        if(ThemeManager.currentTheme() == .dark) {
            teacherTextField.theme = SearchTextFieldTheme.darkTheme()
        }
        
        teacherTextField.maxNumberOfResults = 5
        teacherTextField.minCharactersNumberToStartFiltering = 1
        teacherTextField.theme.font = UIFont.systemFont(ofSize: 24)
        teacherTextField.theme.fontColor = UIColor.white
        teacherTextField.theme.bgColor = UIColor (red: 0, green: 0, blue: 0, alpha: 0.8)
        teacherTextField.theme.borderColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        teacherTextField.theme.separatorColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
        teacherTextField.theme.cellHeight = 50
    
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer)
    {
        teacherTextField.resignFirstResponder()
    }
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
            self.performSegue(withIdentifier: "back", sender: self)
        }
    }

    var teacher: String = ""
    @IBAction func findPressed(_ sender: Any) {
        
        //gets rid of spaces, periods, apostrophes, etc
        //also takes input and turns into lowercase to make switch cases easier
        let input = teacherTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "'", with: "’")
        
        //checks in case the field is left blank or is incorrect
        if input == ""
        {
            
            let failAlert = UIAlertController(title: "Something went wrong", message: "Make sure that you didn't leave the box blank!", preferredStyle: UIAlertControllerStyle.alert)
            failAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(failAlert, animated: true, completion: nil)
 
        }
        else
        {
            teacher = input!
            teacherName = teacher
            self.performSegue(withIdentifier: "accepted", sender: self)
            
        }

    }
 
}

