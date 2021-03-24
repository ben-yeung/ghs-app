//
//  UpdatePatchNotesVC.swift
//  GHSApp
//
//  Created by BY on 12/2/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//
//  This VC will display the updates based on the version user selects
//  We check the global var declared in UpdatesVC 'versionSelect' to display each version

import UIKit

class UpdatePatchNotesVC: UIViewController {

    @IBOutlet var backView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    let theme = ThemeManager.currentTheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = theme.backgroundColor
        self.containerView.backgroundColor = theme.secondaryColor
        self.backView.backgroundColor = theme.backgroundColor
        self.navBar.barTintColor = theme.backgroundColor
        
        switch(versionSelect)
        {
        
        case "0":
            navBar.topItem?.title = "Version 1.4"
            
        case "1":
            navBar.topItem?.title = "Version 1.3"
            
        case "2":
            navBar.topItem?.title = "Version 1.2"
            
        case "3":
            navBar.topItem?.title = "Version 1.1"
            
            
        default:
            break
        }
        
    }
   

}
