//
//  Updates.swift
//  GHSApp
//
//  Created by BY on 12/1/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//
//  This class is used to present GHS App updates. It's like patch notes showing what is new
//  Goal is to present this in a carousel fashion

import UIKit

var versionSelect = String()

class UpdatesVC: UIViewController {

    @IBOutlet var backView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var collectionView: UICollectionView!

    
    var theme = ThemeManager.currentTheme()
    
    var versions = Updates.fetchVersions()
    let cellScaling: CGFloat = 0.8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = theme.backgroundColor
        self.containerView.backgroundColor = theme.secondaryColor
        self.backView.backgroundColor = theme.backgroundColor
        self.navBar.barTintColor = theme.backgroundColor
        
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScaling)
        let cellHeight = floor(screenSize.height * cellScaling)
        
        let insetX = (view.bounds.width - cellWidth) / 2.0
        let insetY = (view.bounds.height - cellHeight) / 2.0
        
        let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        collectionView?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
    }
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
            
            self.performSegue(withIdentifier: "back", sender: self)
            
        }
    }
}

extension UpdatesVC : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return versions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpdateCell", for: indexPath) as! UpdateCell
        
        cell.version = versions[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        switch(indexPath)
        {
        case [0,0]: //default
            count = 0
            ThemeManager.applyTheme(theme: .norm) //see ThemeManager.swift to see the function
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) //delays the segue move since we need to apply theme
            {
                self.performSegue(withIdentifier: "back", sender: self) //moves back to home page
            }
            
            
        case [0,1]: //forest
            count = 1
            ThemeManager.applyTheme(theme: .forest)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) //delays the segue move since we need to apply theme
            {
                self.performSegue(withIdentifier: "back", sender: self) //moves back to home page
            }
            
        case [0,2]: //space
            count = 2
            ThemeManager.applyTheme(theme: .space)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) //delays the segue move since we need to apply theme
            {
                self.performSegue(withIdentifier: "back", sender: self) //moves back to home page
            }
            
        case [0,3]: //darkmode
            count = 3
            ThemeManager.applyTheme(theme: .dark)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) //delays the segue move since we need to apply theme
            {
                self.performSegue(withIdentifier: "back", sender: self) //moves back to home page
            }
            
        case [0,4]: //colorful
            count = 4
            ThemeManager.applyTheme(theme: .colorful)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) //delays the segue move since we need to apply theme
            {
                self.performSegue(withIdentifier: "back", sender: self) //moves back to home page
            }
            
        case [0,5]: //blossom by Sydney Lam
            count = 5
            ThemeManager.applyTheme(theme: .blossom)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) //delays the segue move since we need to apply theme
            {
                self.performSegue(withIdentifier: "back", sender: self) //moves back to home page
            }
            
        case [0,6]: //spring by Katelyn P.
            count = 6
            ThemeManager.applyTheme(theme: .spring)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) //delays the segue move since we need to apply theme
            {
                self.performSegue(withIdentifier: "back", sender: self) //moves back to home page
            }
            
        case [0,7]: //christmas by Ryan Q.
            count = 7
            ThemeManager.applyTheme(theme: .norm)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) //delays the segue move since we need to apply theme
            {
                self.performSegue(withIdentifier: "back", sender: self) //moves back to home page
            }
            
        case [0,8]: //fresh
            count = 8
            ThemeManager.applyTheme(theme: .blossom)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) //delays the segue move since we need to apply theme
            {
                self.performSegue(withIdentifier: "back", sender: self) //moves back to home page
            }
            
        default:
            versionSelect = "-1"
        }
        
        theme = ThemeManager.currentTheme()
        self.refreshTheme()
        UserDefaults.standard.set(count, forKey: "theme")
        print(count)
        
    }
    
    func refreshTheme()
    {
        self.view.backgroundColor = theme.backgroundColor
        self.containerView.backgroundColor = theme.secondaryColor
        self.backView.backgroundColor = theme.backgroundColor
        self.navBar.barTintColor = theme.backgroundColor
    }
}

extension UpdatesVC : UIScrollViewDelegate, UICollectionViewDelegate
{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}

