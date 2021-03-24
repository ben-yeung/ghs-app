//
//  TeacherFound.swift
//  GHSApp
//
//  Created by BY on 2/7/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//

import UIKit
import Alamofire

class TeacherFound: UIViewController {

    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UITextView!
    @IBOutlet weak var room: UILabel!
    @IBOutlet weak var about: UITextView!
    @IBOutlet weak var aboutTxt: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var infoBtn: UIBarButtonItem!
    @IBOutlet var popupView: UIView!
    @IBOutlet weak var popupViewBtn: UIButton!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var popTitle: UILabel!
    @IBOutlet weak var popText: UILabel!
    
    @IBOutlet weak var eggButton: UIButton!
    
    var theme = ThemeManager.currentTheme()
    
    var teacherArray = [AnyObject]()
    var effect : UIVisualEffect? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.name.alpha = 0
        self.email.alpha = 0
        self.room.alpha = 0
        self.about.alpha = 0
        self.aboutTxt.alpha = 0
        self.eggButton.alpha = 0
        
        self.about.indicatorStyle = UIScrollViewIndicatorStyle.white
      
            self.view.backgroundColor = theme.backgroundColor
            self.containerView.backgroundColor = theme.secondaryColor
            self.backView.backgroundColor = theme.backgroundColor
            self.navBar.barTintColor = theme.backgroundColor
            self.bgImage.image = theme.themeImageAlt
            self.popupView.backgroundColor = theme.secondaryColor
            self.popupViewBtn.backgroundColor = theme.backgroundColor
        
        effect = visualEffectView.effect!
        visualEffectView.effect = nil
        popupView.layer.cornerRadius = 20
        self.visualEffectView.alpha = 0
        self.popupView.alpha = 0
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
        
    }
    
    var wrongTeacher = false
    
    @IBAction func infoBtnPressed(_ sender: Any) {
        
        wrongTeacher = false
        
        self.view.addSubview(popupView)
        popupView.center = self.view.center
        popupView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        popupView.alpha = 0
        
        self.popTitle.text = "Something Missing?"
        self.popText.text = "Hey there. We are working on making teacher/staff information organized, but we may make mistakes. If any of the info presented is wrong/missing, please let us know by emailing us at:"
        
        
        UIView.animate(withDuration: 0.5){
            self.visualEffectView.effect = self.effect
            self.popupView.alpha = 1
            self.visualEffectView.alpha = 1
            self.popupView.transform = CGAffineTransform.identity
            
        }
        
    }
    @IBAction func dismissPopup(_ sender: Any) {
        if(wrongTeacher == false)
        {
        UIView.animate(withDuration: 0.1, animations: {
            self.visualEffectView.effect = nil
            self.popupView.alpha = 0
        }, completion: { (true) in
            
            UIView.animate(withDuration: 0.2, animations: {
                
                self.visualEffectView.alpha = 0
                
            })
            
        })
        } else {
            self.performSegue(withIdentifier: "back", sender: self)
        }
        
    }
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
            self.performSegue(withIdentifier: "back", sender: self)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var key: String?
        key = appDelegate.GoogleAPI as String?
        Alamofire.request("https://sheets.googleapis.com/v4/spreadsheets/12MnypDjkhaQpYZxSXX5QuL0_dry23Udmcn5FDlYSh84/values/A2%3AI?key=" + key!).responseJSON { response in
            
            if let json = response.result.value as? Dictionary<String, AnyObject>,
                let names = json["values"] {
                self.teacherArray = (names as? [AnyObject])!
                
                var teacherFound = false
                
                print(teacherName)
                for teachers in self.teacherArray //Transverses "values" which holds each row (each teacher)
                {
                    let stringTeacher = teachers as? [String] //Turns [AnyObject] into [String] so we can get parts of the array
                   
                    if(teacherName == stringTeacher![8])
                    {
                        teacherFound = true
                        //print(stringTeacher![1])
                        let lastFirst = stringTeacher![8].components(separatedBy: ",")
                        
                        UIView.animate(withDuration: 0.5, animations: {
                            self.name.text = stringTeacher![2] + " " + lastFirst[0]
                            self.email.text = stringTeacher![3]
                            self.room.text = stringTeacher![1]
                            self.about.text = stringTeacher![4]
                            self.name.alpha = 1
                            self.email.alpha = 1
                            self.room.alpha = 1
                            self.about.alpha = 1
                            self.aboutTxt.alpha = 1
                            
                            if(teacherName == "Liao, Jimmy")
                            {
                                if(UserDefaults.standard.bool(forKey:"egg1") == true)
                                {
                                    egg2 = true
                                    UserDefaults.standard.set(egg2, forKey: "egg2")
                                }
                            }
                            else
                            {
                                egg2 = false
                                UserDefaults.standard.set(egg2, forKey: "egg2")
                            }
                            
                            if(UserDefaults.standard.bool(forKey: "egg2") == true)
                            {
                                self.eggButton.alpha = 1
                            }
                            
                        })
                    }
                    
                }
                
                if(teacherFound == false)
                {
                    self.wrongTeacher = true
                    
                    self.view.addSubview(self.popupView)
                    self.popupView.center = self.view.center
                    self.popupView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
                    self.popupView.alpha = 0
                    
                    self.popTitle.text = "Staff Not Found"
                    self.popText.text = "Hmm. It seems that the teacher/staff you are looking for is not on our records. It could be that the teacher/staff has not filled out our info sheet. Please email us if there's a mistake."
                    
                    UIView.animate(withDuration: 0.5){
                        self.visualEffectView.effect = self.effect
                        self.popupView.alpha = 1
                        self.visualEffectView.alpha = 1
                        self.popupView.transform = CGAffineTransform.identity
                        
                    }
                    
                }
                
            }
        }
        
    }

    @IBAction func eggPressed(_ sender: Any)
    {
        print("Second egg found: Liao")
        egg2 = true //egg unlocked from Liao's bio
        UserDefaults.standard.set(egg2, forKey: "egg2")
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        //let screenHeight = screenSize.height
        
        let animationView = LOTAnimationView(name: "confetti")
        
        self.view.addSubview(animationView)
        
        animationView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth) //To keep proportions screenWidth is used twice
        
        animationView.center.x = self.view.center.x // for horizontal
        animationView.center.y = self.view.center.y // for vertical
        
        animationView.play{ (finished) in
            animationView.alpha = 0
        }
        
        let liaoAlert = UIAlertController(title: "Too Cool!", message: "You have found another hidden egg in this app! Stay tuned for more hidden features in the coming updates!", preferredStyle: UIAlertControllerStyle.alert)
        
        liaoAlert.addAction(UIAlertAction(title: "Awesome!", style: UIAlertActionStyle.default, handler: nil ))
        self.present(liaoAlert, animated: true, completion: nil)
    }
    

}
