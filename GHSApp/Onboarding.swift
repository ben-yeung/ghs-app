//
//  Onboarding.swift
//  GHSApp
//
//  Created by BY on 7/29/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//

import UIKit
import PaperOnboarding

class Onboarding: UIViewController {
    
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        
        return [
        OnboardingItemInfo(informationImage: UIImage(named: "box-1")!,
                           title: "Hotels",
                           description: "All hotels and hostels are sorted by hospitality rating",
                           pageIcon: UIImage(named: "box-1")!,
                           color: UIColor(red: 0.40, green: 0.56, blue: 0.71, alpha: 1.00),
                           titleColor: UIColor.white,
                           descriptionColor: UIColor.white,
                           titleFont: Onboarding.titleFont,
                           descriptionFont: Onboarding.descriptionFont),
        
        OnboardingItemInfo(informationImage: UIImage(named: "box-1")!,
                           title: "Banks",
                           description: "We carefully verify all banks before add them into the app",
                           pageIcon: UIImage(named: "box-1")!,
                           color: UIColor(red: 0.40, green: 0.69, blue: 0.71, alpha: 1.00),
                           titleColor: UIColor.white,
                           descriptionColor: UIColor.white,
                           titleFont: Onboarding.titleFont,
                           descriptionFont: Onboarding.descriptionFont),
        
        OnboardingItemInfo(informationImage: UIImage(named: "box-1")!,
                           title: "Stores",
                           description: "All local stores are categorized for your convenience",
                           pageIcon: UIImage(named: "box-1")!,
                           color: UIColor(red: 0.61, green: 0.56, blue: 0.74, alpha: 1.00),
                           titleColor: UIColor.white,
                           descriptionColor: UIColor.white,
                           titleFont: Onboarding.titleFont,
                           descriptionFont: Onboarding.descriptionFont),
        
        ][index]
    }
    
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPaperOnboardingView() //Initializes Onboarding View
        
    }
    
    private func setupPaperOnboardingView() {
        let onboarding = PaperOnboarding()
        onboarding.delegate = self
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)
        
        // Add constraints
        for attribute: NSLayoutAttribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            view.addConstraint(constraint)
        }
    }

}


// MARK: PaperOnboardingDelegate

extension Onboarding: PaperOnboardingDelegate {
    
    func onboardingDidTransitonToIndex(_: Int) {
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        //item.titleLabel?.backgroundColor = .redColor()
        //item.descriptionLabel?.backgroundColor = .redColor()
        //item.imageView = ...
    }
}

//MARK: Constants
extension Onboarding {
    
    private static let titleFont = UIFont(name: "Nunito-Bold", size: 36.0) ?? UIFont.boldSystemFont(ofSize: 36.0)
    private static let descriptionFont = UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
}
