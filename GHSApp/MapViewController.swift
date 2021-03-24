//
//  MapViewController.swift
//  GHSApp
//
//  Created by BY on 1/11/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//

import UIKit
import WebKit
class MapViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var backView: UIView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var mapSegment: UISegmentedControl!
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    @IBOutlet weak var containerView: UIView!
    let theme = ThemeManager.currentTheme()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            if let pdf = Bundle.main.url(forResource: "MapWholeCampus", withExtension: "pdf", subdirectory: nil, localization: nil)  {
                let req = NSURLRequest(url: pdf)
                webView.load(req as URLRequest)
            }
            
            self.view.backgroundColor = theme.backgroundColor
            self.backView.backgroundColor = theme.backgroundColor
            self.navBar.barTintColor = theme.backgroundColor
            self.containerView.backgroundColor = theme.backgroundColor
            
            let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
            edgePan.edges = .left
            view.addGestureRecognizer(edgePan)
            
        }

    @IBAction func sharePressed(_ sender: Any) {
        
        let pdf = Bundle.main.url(forResource: "MapWholeCampus", withExtension: "pdf", subdirectory: nil, localization: nil)
        
        if UIDevice.current.userInterfaceIdiom == .pad //the iPad uses a different type of sharing and crashes when using UIActivityViewController
        {
            
            let activityVC = UIActivityViewController(activityItems: [pdf!], applicationActivities: nil)
            activityVC.title = "Share"
            activityVC.excludedActivityTypes = []
            
            activityVC.popoverPresentationController?.sourceView = self.view
            activityVC.popoverPresentationController?.barButtonItem = shareBtn
            
            self.present(activityVC, animated: true, completion: nil)
        }
        else
        {
            let shareVC = UIActivityViewController(activityItems: [pdf!], applicationActivities: [])
            present(shareVC, animated: true)
            
        }
        
    }
    
    @IBAction func backStudent(_ sender: Any) {
        
        if(fromTeacher)
        {
            self.performSegue(withIdentifier: "backTeacher", sender: self)
        } else {
            self.performSegue(withIdentifier: "backStudent", sender: self)
        }
        
    }
    
    //PDFs are found in the PDFs folder
    @IBAction func segmentSwitched(_ sender: Any) {
        
        switch mapSegment.selectedSegmentIndex {
            case 0:
                if let pdf = Bundle.main.url(forResource: "MapWholeCampus", withExtension: "pdf", subdirectory: nil, localization: nil)  {
                    let req = NSURLRequest(url: pdf)
                    webView.load(req as URLRequest)
                }
            
            case 1:
                if let pdf = Bundle.main.url(forResource: "MapWithLabels", withExtension: "pdf", subdirectory: nil, localization: nil)  {
                    let req = NSURLRequest(url: pdf)
                    webView.load(req as URLRequest)
                }
            
            default:
                break
        }
        
    }
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
            if(fromTeacher)
            {
                self.performSegue(withIdentifier: "backTeacher", sender: self)
            } else {
                self.performSegue(withIdentifier: "backStudent", sender: self)
            }
        }
    }

}
    

