//
//  SplashViewController.swift
//  GHSApp
//
//  Created by BY on 2/23/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//  sldkfjsldksdflkjsdflksdjflsksfdj

import UIKit
import Lottie

class SplashViewController: UIViewController {

    
    @IBOutlet var BG: UIImageView!
    @IBOutlet var bgView: UIView!
    
    let theme = ThemeManager.currentTheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        count = UserDefaults.standard.integer(forKey: "theme")
        
        if(count == -1) //secret
        {
            BG.image = UIImage(named: "secretImg")
            bgView.backgroundColor = UIColor.black
        }
        else if(count == 1) //forest
        {
            BG.image = UIImage(named: "trees")
            bgView.backgroundColor = UIColor.black
        }
        else if(count == 2) //space
        {
            BG.image = UIImage(named: "earth")
        }
        else if(count == 3) //dark
        {
            BG.image = UIImage(named: "none")
            bgView.backgroundColor = rgbaToUIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1)
            view.backgroundColor = UIColor.black
        }
        else if(count == 4) //colorufl
        {
            BG.image = UIImage(named: "colorfulBtn")
            bgView.backgroundColor = rgbaToUIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        }
        else if(count == 5) //blossom
        {
            BG.image = UIImage(named: "blossom")
            bgView.backgroundColor = theme.backgroundColor
        }
        else if(count == 6) //spring
        {
            BG.image = UIImage(named: "spring")
            bgView.backgroundColor = theme.backgroundColor
        }
        else if(count == 7) //christmas
        {
            BG.image = UIImage(named: "christmasLoading")
            bgView.backgroundColor = theme.backgroundColor
        }
        else if(count == 8) //fresh
        {
            BG.image = UIImage(named: "none")
            bgView.backgroundColor = theme.backgroundColor
        }
        else //default
        {
            BG.image = UIImage(named: "none")
            bgView.backgroundColor = rgbaToUIColor(red: 180/255, green: 24/255, blue: 38/255, alpha: 1)
            count = 0
            
        }
        
        let animationView = LOTAnimationView(name: "Better Ben Waves.json")
        
        self.view.addSubview(animationView)
        
        animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 120)
        
        animationView.center.x = self.view.center.x // for horizontal
        animationView.center.y = self.view.center.y // for vertical
        
        animationView.play{ (finished) in
            self.performSegue(withIdentifier: "fin", sender: self)
        }
        
    }
    

}
//hi ben
