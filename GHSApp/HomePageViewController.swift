//
//  HomePageViewController.swift
//  GHSApp
//
//  Created by BY on 10/12/17.
//  Copyright © 2017 GHSAppClub. All rights reserved.
//

import UIKit
import SwiftyJSON
import TwitterKit
import TwitterCore
import Firebase
import Alamofire

var count = Int()
var egg1 = Bool() 
var egg2 = Bool()
var egg3 = Bool()
var egg4 = Bool()

var welcomeBack = Bool()

var showTip = Bool()


class HomePageViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    
    @IBOutlet weak var bgImage: UIImageView!
    
    @IBOutlet weak var ghsLogo: SpringImageView!
    
    @IBOutlet weak var srBtn: SpringButton!
    
    @IBOutlet weak var trBtn: SpringButton!
    
    @IBOutlet weak var cBtn: SpringButton!

    @IBOutlet weak var conBtn: SpringButton!
    
    @IBOutlet weak var oBtn: SpringButton!
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet var views: UIView!
    
    @IBOutlet weak var activateBtn: UIButton!
    
    @IBOutlet weak var notifBtn: SpringButton!
    @IBOutlet weak var notifView: SpringView!
    @IBOutlet weak var userBtn: SpringButton!
    @IBOutlet weak var userView: SpringView!
    @IBOutlet weak var userBG: UIImageView!
    @IBOutlet weak var notifBG: UIImageView!
    
    let theme = ThemeManager.currentTheme()
    
    var conditionals = [String]()
    
    //see addSnow() for details
    let flakeEmitterCell = CAEmitterCell()
    let snowEmitterLayer = CAEmitterLayer()
    
    var hidden = false
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var key: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        key = appDelegate.GoogleAPI as String?
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .right
        view.addGestureRecognizer(edgePan)
        
        userBtn.imageView?.contentMode = .scaleAspectFit
        notifBtn.imageView?.contentMode = .scaleAspectFit
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: "Long") //Long function will call when user long presses a button.
        activateBtn.addGestureRecognizer(longGesture)
        
        let longSecret = UILongPressGestureRecognizer(target: self, action: "secretLong")
        oBtn.addGestureRecognizer(longSecret)
        
        count = UserDefaults.standard.integer(forKey: "theme")
        egg1 = UserDefaults.standard.bool(forKey: "egg1")
        egg2 = UserDefaults.standard.bool(forKey: "egg2")
        egg3 = UserDefaults.standard.bool(forKey: "egg3")
        egg4 = UserDefaults.standard.bool(forKey: "egg4")
        print(count)

        self.checkTheme()
        self.createConditionList()
        
        
        self.srBtn.alpha = 0
        self.trBtn.alpha = 0
        self.oBtn.alpha = 0
        self.ghsLogo.alpha = 0
        self.conBtn.alpha = 0
        self.cBtn.alpha = 0
        self.notifBtn.alpha = 0
        self.userBtn.alpha = 0
        self.notifView.alpha = 0
        self.userView.alpha = 0
        
        self.becomeFirstResponder() // Activates shake gesture detection
        
} //End of ViewDidLoad
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
    }
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
            
            if(!hidden)
            {
                self.userView.alpha = 0
                self.notifView.alpha = 0
                
                self.hidden = true
            }
            else
            {
                self.userView.alpha = 1
                self.notifView.alpha = 1
                
                self.hidden = false
            }
            
        }
    }
    
    func Long() //function for long pressing GHS Button
    {
        count = -1
        UserDefaults.standard.set(count, forKey: "theme")
        self.checkTheme()
    }
    
    func secretLong()
    {
        self.performSegue(withIdentifier: "secret", sender: self)
    }
    
    //enables watch for shake gesture
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    // Enable detection of shake motion
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("Woah the phone is shaking")
            egg1 = true //egg unlocked, to be checked in Liao's bio
            UserDefaults.standard.set(egg1, forKey: "egg1")
            
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
            
            let shakeAlert = UIAlertController(title: "Hey don't shake me!", message: "You have found one of the many hidden features on this app! Can anyone tell me more about Mr. Liao?", preferredStyle: UIAlertControllerStyle.alert)
            
            shakeAlert.addAction(UIAlertAction(title: "Woah!", style: UIAlertActionStyle.default, handler: nil ))
            self.present(shakeAlert, animated: true, completion: nil)
            
        }
    }
    
    /** Account stuff to check if user is already logged in. Not used as of 12/01/2018
    @IBAction func accountPress(_ sender: Any)
    {
        let authListener = Auth.auth().addStateDidChangeListener { auth, user in
            
            if user != nil {
                self.performSegue(withIdentifier: "authSuccess", sender: self)
            } else {
                //Login Page
                self.performSegue(withIdentifier: "accountMove", sender: self)
            }
        }
    
        
    }
     **/
    
    override func viewDidAppear(_ animated: Bool) {
        
        key = appDelegate.GoogleAPI as String?
        self.checkTheme()

        //animates buttons into view
        UIView.animate(withDuration: 1.5, animations: {
            self.notifBtn.animation = "fadeIn"
            self.notifBtn.animate()
            self.userBtn.animation = "fadeIn"
            self.userBtn.animate()
            
            
            self.notifView.animation = "fadeIn"
            self.notifView.animate()
            self.userView.animation = "fadeIn" //Originally used for account logins now is for update screen
            self.userView.animate()
 
            self.ghsLogo.animation = "fadeIn"
            self.ghsLogo.animate()
        }, completion: { (true) in
            
        UIView.animate(withDuration: 1.75, animations: {
            self.srBtn.animation = "fadeIn"
            self.srBtn.animate()
        }, completion: { (true) in
            
            UIView.animate(withDuration: 2, animations: {
                self.trBtn.animation = "fadeIn"
                self.trBtn.animate()
            }, completion: { (true) in
                
                UIView.animate(withDuration: 2.25, animations: {
                    self.cBtn.animation = "fadeIn"
                    self.cBtn.animate()
                    
                    }, completion: { (true) in
                        
                        UIView.animate(withDuration: 2.25, animations: {
                            self.conBtn.animation = "fadeIn"
                            self.conBtn.animate()
                            
                    }, completion: { (true) in
                        
                            UIView.animate(withDuration: 2.25, animations: {
                                self.oBtn.animation = "fadeIn"
                                self.oBtn.animate()
                                
                            
                    })
                })
                
            })
            
        })
    })
 })
} //End of ViewDidAppear
    
    
    @IBAction func actionPressed(_ sender: Any)
    {
        
        count += 1
        UserDefaults.standard.set(count, forKey: "theme")
        self.checkTheme()
    }
    
    func addSnow()
    {
        //see Christmas Effects folder for swift file detailing functions below
        
        flakeEmitterCell.contents = UIImage(named: "snowFlake")?.cgImage
        flakeEmitterCell.scale = 0.06
        flakeEmitterCell.scaleRange = 0.3
        flakeEmitterCell.emissionRange = .pi
        flakeEmitterCell.lifetime = 20.0
        flakeEmitterCell.birthRate = 40
        flakeEmitterCell.velocity = -30
        flakeEmitterCell.velocityRange = -20
        flakeEmitterCell.yAcceleration = 30
        flakeEmitterCell.xAcceleration = 5
        flakeEmitterCell.spin = -0.5
        flakeEmitterCell.spinRange = 1.0
        
        snowEmitterLayer.emitterPosition = CGPoint(x: view.bounds.width / 2.0, y: -50)
        snowEmitterLayer.emitterSize = CGSize(width: view.bounds.width, height: 0)
        snowEmitterLayer.emitterShape = kCAEmitterLayerLine
        snowEmitterLayer.beginTime = CACurrentMediaTime()
        snowEmitterLayer.timeOffset = 10
        snowEmitterLayer.emitterCells = [flakeEmitterCell]
        
        view.layer.addSublayer(snowEmitterLayer) //useful to add effects without interfering with buttons
        
    }
    
    func removeSnow()
    {
        snowEmitterLayer.removeFromSuperlayer()
    }
    
    func checkTheme()
    {
        if(count == -1)
        {
            ThemeManager.applyTheme(theme: .secret)
            
            ghsLogo.alpha = 1
            ghsLogo.image = UIImage(named: "white")
            view.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7)
            bgImage.image = UIImage(named: "secretImg")
            bgView.backgroundColor = UIColor.black
            notifView.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
            userView.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
            notifBG.image = UIImage(named: "none")
            userBG.image = UIImage(named: "none")
            srBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
            trBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
            cBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
            conBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
            oBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7)
            
        }
        else if(count == 1)
        {
            ThemeManager.applyTheme(theme: .forest)
            
            ghsLogo.alpha = 1
            ghsLogo.image = UIImage(named: "white")
            view.backgroundColor = rgbaToUIColor(red: 15/255, green: 16/255, blue: 17/255, alpha: 1)
            bgImage.image = UIImage(named: "trees")
            bgView.backgroundColor = UIColor.black
            notifView.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
            userView.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
            notifBG.image = UIImage(named: "none")
            userBG.image = UIImage(named: "none")
            srBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
            trBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
            cBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7)
            conBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.8)
            oBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.9)
            
        }
        else if(count == 2)
        {
            ThemeManager.applyTheme(theme: .space)
            ghsLogo.alpha = 1
            ghsLogo.image = UIImage(named: "ghsNasa")
            view.backgroundColor = rgbaToUIColor(red: 10/255, green: 19/255, blue: 25/255, alpha: 1)
            bgImage.image = UIImage(named: "earthHome")
            bgView.backgroundColor = UIColor.black
            notifView.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
            userView.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
            notifBG.image = UIImage(named: "none")
            userBG.image = UIImage(named: "none")
            srBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)
            trBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
            cBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
            conBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
            oBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
            
        }
        else if(count == 3)
        {
            ThemeManager.applyTheme(theme: .dark)
            ghsLogo.alpha = 1
            ghsLogo.image = UIImage(named: "darkMode")
            view.backgroundColor = rgbaToUIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
            bgImage.image = UIImage(named: "none")
            notifView.backgroundColor = rgbaToUIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.035)
            userView.backgroundColor = rgbaToUIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.035)
            notifBG.image = UIImage(named: "none")
            userBG.image = UIImage(named: "none")
            bgView.backgroundColor = rgbaToUIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1)
            srBtn.backgroundColor = rgbaToUIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.035)
            trBtn.backgroundColor = rgbaToUIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.025)
            cBtn.backgroundColor = rgbaToUIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.02)
            conBtn.backgroundColor = rgbaToUIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.015)
            oBtn.backgroundColor = rgbaToUIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.01)
            
        }
        else if(count == 4)
        {
            ThemeManager.applyTheme(theme: .colorful)
            ghsLogo.alpha = 1
            ghsLogo.image = UIImage(named: "colorful")
            view.backgroundColor = rgbaToUIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1) //seen by iPhoneX screens
            bgImage.image = UIImage(named: "none")
            notifView.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)
            userView.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)
            notifBG.image = UIImage(named: "none")
            userBG.image = UIImage(named: "none")
            bgView.backgroundColor = rgbaToUIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
            srBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.15)
            trBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)
            cBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
            conBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
            oBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
            
        }
        
        else if(count == 5) //blossom
        {
             ThemeManager.applyTheme(theme: .blossom)
             ghsLogo.alpha = 1
             ghsLogo.image = UIImage(named: "white")
             view.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.8)
             bgImage.image = UIImage(named: "blossom")
             notifView.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
             userView.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
             notifBG.image = UIImage(named: "none")
             userBG.image = UIImage(named: "none")
             bgView.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.8)
             srBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
             trBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
             cBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
             conBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
             oBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7)
            
            
        }
            
        else if(count == 6) //blossom
        {
            ThemeManager.applyTheme(theme: .spring)
            ghsLogo.alpha = 1
            ghsLogo.image = UIImage(named: "white")
            view.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.8)
            bgImage.image = UIImage(named: "spring")
            notifView.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
            userView.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
            notifBG.image = UIImage(named: "none")
            userBG.image = UIImage(named: "none")
            bgView.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.8)
            srBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
            trBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
            cBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
            conBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
            oBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7)
            
            
        }
        
        else if(count == 7) //christmas
        {
            ThemeManager.applyTheme(theme: .norm)
            ghsLogo.alpha = 1
            ghsLogo.image = UIImage(named: "christmasLogo")
            view.backgroundColor = rgbaToUIColor(red: 86/255, green: 24/255, blue: 38/255, alpha: 1)
            bgImage.image = UIImage(named: "none")
            notifView.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)
            userView.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)
            notifBG.image = UIImage(named: "none")
            userBG.image = UIImage(named: "none")
            bgView.backgroundColor = rgbaToUIColor(red: 180/255, green: 24/255, blue: 38/255, alpha: 1)
            srBtn.backgroundColor = rgbaToUIColor(red: 160/255, green: 24/255, blue: 38/255, alpha: 1)
            trBtn.backgroundColor = rgbaToUIColor(red: 147/255, green: 24/255, blue: 38/255, alpha: 1)
            cBtn.backgroundColor = rgbaToUIColor(red: 128/255, green: 24/255, blue: 38/255, alpha: 1)
            conBtn.backgroundColor = rgbaToUIColor(red: 110/255, green:24/255, blue: 38/255, alpha: 1)
            oBtn.backgroundColor = rgbaToUIColor(red: 86/255, green: 24/255, blue: 38/255, alpha: 1)
            
            self.addSnow()
        }
          /**
        else if(count == 7) //soph
        {
            
            ThemeManager.applyTheme(theme: .soph)
            ghsLogo.alpha = 1
            ghsLogo.image = UIImage(named: "soph")
            view.backgroundColor = rgbaToUIColor(red: 0/255, green: 51/255, blue: 108/255, alpha: 1)
            bgImage.image = UIImage(named: "none")
            notifView.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
            userView.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
            notifBG.image = UIImage(named: "none")
            userBG.image = UIImage(named: "none")
            bgView.backgroundColor = rgbaToUIColor(red: 0/255, green: 103/255, blue: 219/255, alpha: 1)
            srBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.15)
            trBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)
            cBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
            conBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
            oBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
            UIApplication.shared.statusBarStyle = .lightContent
            
        }
        else if(count == 8) //freshmen
        {
            ThemeManager.applyTheme(theme: .blossom)
            ghsLogo.alpha = 1
            ghsLogo.image = UIImage(named: "white")
            view.backgroundColor = rgbaToUIColor(red: 33/255, green: 104/255, blue: 2/255, alpha: 1)
            bgImage.image = UIImage(named: "blossomAlt")
            notifView.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
            userView.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
            notifBG.image = UIImage(named: "none")
            userBG.image = UIImage(named: "none")
            bgView.backgroundColor = rgbaToUIColor(red: 67/255, green: 211/255, blue: 5/255, alpha: 1)
            srBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.15)
            trBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)
            cBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
            conBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
            oBtn.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
            UIApplication.shared.statusBarStyle = .lightContent
            
        }**/
        else
        {
            self.removeSnow()
            
            ThemeManager.applyTheme(theme: .norm)
            ghsLogo.alpha = 1
            ghsLogo.image = UIImage(named: "white")
            view.backgroundColor = rgbaToUIColor(red: 86/255, green: 24/255, blue: 38/255, alpha: 1)
            bgImage.image = UIImage(named: "none")
            notifView.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)
            userView.backgroundColor = rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)
            notifBG.image = UIImage(named: "none")
            userBG.image = UIImage(named: "none")
            bgView.backgroundColor = rgbaToUIColor(red: 180/255, green: 24/255, blue: 38/255, alpha: 1)
            srBtn.backgroundColor = rgbaToUIColor(red: 160/255, green: 24/255, blue: 38/255, alpha: 1)
            trBtn.backgroundColor = rgbaToUIColor(red: 147/255, green: 24/255, blue: 38/255, alpha: 1)
            cBtn.backgroundColor = rgbaToUIColor(red: 128/255, green: 24/255, blue: 38/255, alpha: 1)
            conBtn.backgroundColor = rgbaToUIColor(red: 110/255, green:24/255, blue: 38/255, alpha: 1)
            oBtn.backgroundColor = rgbaToUIColor(red: 86/255, green: 24/255, blue: 38/255, alpha: 1)
            
            
            count = 0
            
        }
        
    }
    
    //function to check conditionals for live events || see the link for order of conditionals
    // https://docs.google.com/spreadsheets/d/1aPsMjTHuaNYBFausBqi6ZSJI9Tp7eMIO7fcmFYCr_Us/edit#gid=0
    func createConditionList()
    {
        Alamofire.request("https://sheets.googleapis.com/v4/spreadsheets/1aPsMjTHuaNYBFausBqi6ZSJI9Tp7eMIO7fcmFYCr_Us/values/B1%3AB?key=" + key!).responseJSON { response in
            
            if let json = response.result.value as? Dictionary<String, AnyObject>,
                let names = json["values"] {
                let conditionsNamed = (names as? [AnyObject])!
                
                for condition in conditionsNamed
                {
                    let stringCondition = condition as? [String]
                    self.conditionals.append(stringCondition![0])
                }
                
                //print(self.conditionals)
                self.checkConditions()
            
            }
            
        }
    }
    
    func checkConditions() //check conditionals of the conditionals array
    {
        
        if(self.conditionals[0] == "TRUE") //april fools to flip screen
        {
            self.view.transform = self.view.transform.rotated(by: CGFloat(Double.pi))
            
            let animationView = LOTAnimationView(name: "chick.json")
            let height = UIScreen.main.bounds.size.height //get device height
            
            self.view.addSubview(animationView)
            
            animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
            animationView.transform = CGAffineTransform(rotationAngle: .pi)
            animationView.center.x = self.view.center.x // for horizontal
            
            print(height - 200)
            
            animationView.loopAnimation = true
            animationView.play()
        }
        
    }

    
        
}
    

    
    

