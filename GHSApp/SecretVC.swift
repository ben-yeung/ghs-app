//
//  SecretVC.swift
//  GHSApp
//
//  Created by BY on 1/30/19.
//  Copyright © 2019 GHSAppClub. All rights reserved.
//

import UIKit
import Lottie

class SecretVC: UIViewController {

    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var backView: UIView!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var quote: UILabel!
    @IBOutlet weak var author: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var creditBG: UIImageView!
    
    let theme = ThemeManager.currentTheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = theme.backgroundColor
        self.contentView.backgroundColor = theme.secondaryColor
        self.backView.backgroundColor = theme.backgroundColor
        self.navBar.barTintColor = theme.backgroundColor
        
        self.label1.alpha = 0
        self.label2.alpha = 0
        self.scrollView.alpha = 0
        self.creditBG.alpha = 0
        self.quote.alpha = 0
        self.author.alpha = 0
        
        runLabels()
        
    }
    

    
    func runLabels()
    {
        UIView.animate(withDuration: 1, animations: {
            
            //start of fade in labels
            
        }, completion: { (true) in
            
            UIView.animate(withDuration: 2, animations: {
                
                self.label1.alpha = 1
            
        }, completion: { (true) in
            
            UIView.animate(withDuration: 2, animations: {
                
                self.label2.alpha = 1
                
            }, completion: { (true) in
                
                UIView.animate(withDuration: 2, animations: {
                    
                    self.label1.alpha = 0
                    self.label2.alpha = 0
                
                }, completion: { (true) in
                    
                    self.showScroll()
                
                    })
                
                })
            })
        })
    }
    
    func showScroll()
    {
        UIView.animate(withDuration: 2, animations: {
            
            self.scrollView.alpha = 1
            self.creditBG.alpha = 1
            
        })
        
        let timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
        let animateTimer = Timer.scheduledTimer(timeInterval: 50, target: self, selector: #selector(runQuote), userInfo: nil, repeats: false)
        
        let endingTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(endScreen), userInfo: nil, repeats: false)
        
    }
    
    @objc func endScreen()
    {
        self.performSegue(withIdentifier: "back", sender: self)
    }
    
    @objc func runAnimation()
    {
        let animationView = LOTAnimationView(name: "secret.json")
        
        self.contentView.insertSubview(animationView, belowSubview: self.scrollView)
        
        animationView.frame = CGRect(x: 0, y: 0, width: 350, height: 350)
        
        animationView.center.x = self.view.center.x // for horizontal
        animationView.center.y = self.view.center.y // for vertical
        animationView.loopAnimation = true
        animationView.alpha = 0
        
        animationView.play()
        
        UIView.animate(withDuration: 2.5) {
            animationView.alpha = 1
        }
    }
    
    @objc func runQuote()
    {
        UIView.animate(withDuration: 3, animations: {
            
            self.quote.alpha = 1
            
        }, completion: { (true) in
            
            UIView.animate(withDuration: 2, animations: {
                
                self.author.alpha = 1
            })
            
        })
                
    }
    
    var yOffset: CGFloat = 0
    
    @objc func timerAction()
    {
        
        yOffset += 15
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.0) {
                self.scrollView.contentOffset.y = self.yOffset
            }
        }
    }
    


}
