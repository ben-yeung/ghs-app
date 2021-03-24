//
//  ContactViewController.swift
//  GHSApp
//
//  Created by BY on 11/23/17.
//  Copyright © 2017 GHSAppClub. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {

    @IBOutlet weak var webBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        let URL = NSURL(string: "https://aeries.glendora.k12.ca.us/ParentPortal/LoginParent.aspx?page=default.aspx")
        
        webBtn.loadRequest(NSURLRequest(url: URL! as URL) as URLRequest)
        
        
        // Do any additional setup after loading the view.
    }

    

}
