//
//  ThemeManager.swift
//  GHSApp
//
//  Created by BY on 7/16/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//

import UIKit
import Foundation

extension UIColor {
    func colorFromHexString (_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
enum Theme: Int {
    
    //ACTION themes are under blossom, spring, junior, senior
    case norm, forest, space, dark, colorful, secret, blossom, spring, junior, senior
    
    //Color for Buttons
    var buttonColor: UIColor {
        switch self {
        case .norm:
            return rgbaToUIColor(red: 198/255, green: 24/255, blue: 38/255, alpha: 1)
        case .forest:
            return rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        case .space:
            return rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
        case .dark:
            return rgbaToUIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
        case .colorful:
            return rgbaToUIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        case .secret:
            return rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        case .blossom:
            return rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        case .spring:
            return rgbaToUIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        case .junior:
            return rgbaToUIColor(red: 240/255, green: 171/255, blue: 0/255, alpha: 1)
        case .senior:
            return rgbaToUIColor(red: 200/255, green: 0/255, blue: 30/255, alpha: 1)
        }
    }
    
    //Background Color
    var backgroundColor: UIColor {
        switch self {
        case .norm:
            return rgbaToUIColor(red: 198/255, green: 24/255, blue: 38/255, alpha: 1)
        case .forest:
            return rgbaToUIColor(red: 26/255, green: 22/255, blue: 22/255, alpha: 1)
        case .space:
            return rgbaToUIColor(red: 16/255, green: 32/255, blue: 44/255, alpha: 1)
        case .dark:
            return rgbaToUIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
        case .colorful:
            return rgbaToUIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        case .secret:
            return rgbaToUIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        case .blossom:
            return rgbaToUIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        case .spring:
            return rgbaToUIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        case .junior:
            return rgbaToUIColor(red: 240/255, green: 171/255, blue: 0/255, alpha: 1)
        case .senior:
            return rgbaToUIColor(red: 220/255, green: 0/255, blue: 38/255, alpha: 1)
        }
    }
    
    //Alternate Background Color or general
    var secondaryColor: UIColor {
        switch self {
        case .norm:
            return rgbaToUIColor(red: 165/255, green: 24/255, blue: 38/255, alpha: 1)
        case .forest:
            return rgbaToUIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        case .space:
            return rgbaToUIColor(red: 24/255, green: 47/255, blue: 63/255, alpha: 1)
        case .dark:
            return rgbaToUIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1)
        case .colorful:
            return rgbaToUIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1)
        case .secret:
            return rgbaToUIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        case .blossom:
            return rgbaToUIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1)
        case .spring:
            return rgbaToUIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1)
        case .junior:
            return rgbaToUIColor(red: 208/255, green: 152/255, blue: 13/255, alpha: 1)
        case .senior:
            return rgbaToUIColor(red: 142/255, green: 0/255, blue: 23/255, alpha: 1)
        }
    }
    
    var tableColor: UIColor {
        switch self {
        case .norm:
            return UIColor.white
        case .forest:
            return UIColor.white
        case .space:
            return UIColor.white
        case .dark:
            return rgbaToUIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
        case .colorful:
            return rgbaToUIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        case .secret:
            return UIColor.white
        case .blossom:
            return UIColor.white
        case .spring:
            return UIColor.white
        case .junior:
            return rgbaToUIColor(red: 208/255, green: 152/255, blue: 13/255, alpha: 1)
        case .senior:
            return rgbaToUIColor(red: 170/255, green: 0/255, blue: 14/255, alpha: 1)
        }
        
    }
    
    var themeImage: UIImage{
        switch self {
        case .norm:
            let img = UIImage(named: "none")!
            return img
        case .forest:
            let img = UIImage(named: "trees")!
            return img
        case .space:
            let img = UIImage(named: "earthLong")!
            return img
        case .dark:
            let img = UIImage(named: "none")!
            return img
        case .colorful:
            let img = UIImage(named: "colorfulBtn")!
            return img
        case .secret:
            let img = UIImage(named: "secretImg")!
            return img
        case .blossom:
            let img = UIImage(named: "blossom")!
            return img
        case .spring:
            let img = UIImage(named: "spring")!
            return img
        case .junior:
            let img = UIImage(named: "none")!
            return img
        case .senior:
            let img = UIImage(named: "none")!
            return img
        }
    }
    
    var themeImageAlt: UIImage{
        switch self {
        case .norm:
            let img = UIImage(named: "none")!
            return img
        case .forest:
            let img = UIImage(named: "trees2")!
            return img
        case .space:
            let img = UIImage(named: "earth")!
            return img
        case .dark:
            let img = UIImage(named: "none")!
            return img
        case .colorful:
            let img = UIImage(named: "colorfulAlt")!
            return img
        case .secret:
            let img = UIImage(named: "secretImgAlt")!
            return img
        case .blossom:
            let img = UIImage(named: "blossomAlt")!
            return img
        case .spring:
            let img = UIImage(named: "springAlt")!
            return img
        case .junior:
            let img = UIImage(named: "none")!
            return img
        case .senior:
            let img = UIImage(named: "none")!
            return img
        }
    }
    
    //NavBar text or Button text
    var textColor: UIColor {
        switch self {
        case .norm:
            return UIColor.black
        case .forest:
            return UIColor.black
        case .space:
            return UIColor.black
        case .dark:
            return UIColor().colorFromHexString("ffffff")
        case .colorful:
            return UIColor.white
        case .secret:
            return UIColor.black
        case .blossom:
            return UIColor.black
        case .spring:
            return UIColor.black
        case .junior:
            return UIColor.white
        case .senior:
            return UIColor.white
        }
        
    }
    
    //Secondary text
    var subtitleTextColor: UIColor {
        switch self {
        case .forest:
            return UIColor().colorFromHexString("ffffff")
        case .space:
            return UIColor().colorFromHexString("000000")
        case .norm:
            return UIColor().colorFromHexString("ffffff")
        case .dark:
            return UIColor().colorFromHexString("ffffff")
        case .colorful:
            return UIColor().colorFromHexString("ffffff")
        case .secret:
            return UIColor().colorFromHexString("ffffff")
        case .blossom:
            return UIColor().colorFromHexString("ffffff")
        case .spring:
            return UIColor().colorFromHexString("ffffff")
        case .junior:
            return UIColor().colorFromHexString("ffffff")
        case .senior:
            return UIColor().colorFromHexString("ffffff")
        }
    }
    
    //changes the background img of the two views for notifications and theme select on homepage
    //currently not being used
    var btnBG: UIImage {
        switch self {
        case .forest:
            let img = UIImage(named: "none")!
            return img
        case .space:
            let img = UIImage(named: "none")!
            return img
        case .norm:
            let img = UIImage(named: "none")!
            return img
        case .dark:
            let img = UIImage(named: "none")!
            return img
        case .colorful:
            let img = UIImage(named: "none")!
            return img
        case .secret:
            let img = UIImage(named: "none")!
            return img
        case .blossom:
            let img = UIImage(named: "none")!
            return img
        case .spring:
            let img = UIImage(named: "none")!
            return img
        case .junior:
            let img = UIImage(named: "none")!
            return img
        case .senior:
            let img = UIImage(named: "none")!
            return img
            
        }
    }
}

// Enum declaration
let SelectedThemeKey = "SelectedTheme"

// This will let you use a theme in the app.
class ThemeManager {
    
    // ThemeManager
    //Theme is applied using 'ThemeManager.applyTheme(theme: 'ThemeName (ex: .norm)' see the function below
    static func currentTheme() -> Theme {
        if let storedTheme = (UserDefaults.standard.value(forKey: SelectedThemeKey) as AnyObject).integerValue {
            return Theme(rawValue: storedTheme)!
        } else {
            return .norm
        }
    }
    
    static func applyTheme(theme: Theme) {
        // First persist the selected theme using NSUserDefaults.
        UserDefaults.standard.setValue(theme.rawValue, forKey: SelectedThemeKey)
        UserDefaults.standard.synchronize()
        
        // You get your current (selected) theme and apply the main color to the tintColor property of your application’s window.
        let sharedApplication = UIApplication.shared
        
        
    }
}
