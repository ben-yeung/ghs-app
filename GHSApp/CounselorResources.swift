//
//  CounselorResources.swift
//  GHSApp
//
//  Created by BY on 1/31/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//

import UIKit
import SafariServices

class CounselorResources: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var navBar: UINavigationBar!
    @IBOutlet var backView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var bgView: UIView!
    
    let theme = ThemeManager.currentTheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.isDirectionalLockEnabled = true
        scrollView.alwaysBounceVertical = true
        
        for button in self.buttons {
            self.view.backgroundColor = theme.backgroundColor
            self.scrollView.backgroundColor = theme.secondaryColor
            self.bgView.backgroundColor = theme.secondaryColor
            self.backView.backgroundColor = theme.backgroundColor
            self.navBar.barTintColor = theme.backgroundColor
            button.backgroundColor = theme.buttonColor
            self.imageView.image = theme.themeImage
        }
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
            self.performSegue(withIdentifier: "back", sender: self)
        }
    }
    
    func showWebsite(url: String)
    {
        let URL = NSURL(string: url)!
        let webVC = SFSafariViewController(url: URL as URL)
        if #available(iOS 10.0, *) {
            if(count == 0)
            {
                webVC.preferredBarTintColor = rgbaToUIColor(red: 182/255, green: 22/255, blue: 22/255, alpha: 1)
            }
            else if(count == 1)
            {
                webVC.preferredBarTintColor = rgbaToUIColor(red: 26/255, green: 22/255, blue: 22/255, alpha: 1)
            }
            else if(count == 2)
            {
                webVC.preferredBarTintColor = rgbaToUIColor(red: 16/255, green: 32/255, blue: 44/255, alpha: 1)
            }
            else if(count == 3)
            {
                webVC.preferredBarTintColor = rgbaToUIColor(red: 26/255, green: 22/255, blue: 22/255, alpha: 1)
            }
            else if(count == 4)
            {
                webVC.preferredBarTintColor = rgbaToUIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
            }
        } else {
            // Fallback on earlier versions
        }
        present(webVC, animated: true, completion: nil)
    }
    
    @IBAction func navianceTap(_ sender: Any) {
        
        self.showWebsite(url: "https://connection.naviance.com/family-connection/auth/login/?hsid=glen")
    }
    
    
    @IBAction func financialTap(_ sender: Any) {
        
        self.showWebsite(url: "http://ghs-glendorausd-ca.schoolloop.com/file/1442645559303/1293637339909/6649054163835133678.pdf")
    }
    
    @IBAction func registrationTap(_ sender: Any) {
        
        self.showWebsite(url: "https://ghs-glendorausd-ca.schoolloop.com/news/view?d=x&id=1375544041247")
        
    }
    
    @IBAction func handbookTap(_ sender: Any) {
        
        self.showWebsite(url: "http://ghs-glendorausd-ca.schoolloop.com/file/1294471769498/1377365220282/3574911730512693371.pdf")
        
    }
}

