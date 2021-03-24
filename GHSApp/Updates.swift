//
//  Updates.swift
//  GHSApp
//
//  Created by BY on 12/1/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//
//  This is the collection of updates.
//  Make a new item whenever you update explaining what's changed

import Foundation

class Updates
{
    var featuredImage: UIImage
    var color: UIColor
    var title: String
    
    init(title: String, featuredImage: UIImage, color: UIColor)
    {
        self.featuredImage = featuredImage
        self.color = color
        self.title = title
    }
    
    //To add a new version patch note make a Updates() with the parameters before the most recent one
    //Copy the structure of the previous ones and make changes accordingly
    //The carousel is filled from top to bottom corresponding to left to right so the most top item will be featured first
    static func fetchVersions() -> [Updates]
    {
        return [
            Updates(title: "Default",
                    featuredImage: UIImage(named: "defaultSC")!,
                    color: UIColor(red: 20/255.0, green: 20/255.0, blue: 20/255.0, alpha: 0.4)),
            
            Updates(title: "Forest",
                    featuredImage: UIImage(named: "forestSC")!,
                    color: UIColor(red: 20/255.0, green: 20/255.0, blue: 20/255.0, alpha: 0.4)),
            
            Updates(title: "Space",
                    featuredImage: UIImage(named: "spaceSC")!,
                    color: UIColor(red: 20/255.0, green: 20/255.0, blue: 20/255.0, alpha: 0.4)),
            
            Updates(title: "Dark",
                    featuredImage: UIImage(named: "darkSC")!,
                    color: UIColor(red: 20/255.0, green: 20/255.0, blue: 20/255.0, alpha: 0.4)),
            
            Updates(title: "Color",
                    featuredImage: UIImage(named: "colorfulSC")!,
                    color: UIColor(red: 20/255.0, green: 20/255.0, blue: 20/255.0, alpha: 0.4)),
            
            Updates(title: "Blossom",
                    featuredImage: UIImage(named: "blossomSC")!,
                    color: UIColor(red: 20/255.0, green: 20/255.0, blue: 20/255.0, alpha: 0.4)),
            
            Updates(title: "Spring",
                    featuredImage: UIImage(named: "springSC")!,
                    color: UIColor(red: 20/255.0, green: 20/255.0, blue: 20/255.0, alpha: 0.4)),
            
            Updates(title: "Christmas",
                    featuredImage: UIImage(named: "christmasSC")!,
                    color: UIColor(red: 20/255.0, green: 20/255.0, blue: 20/255.0, alpha: 0.4)),
            
            
            /**
            Updates(title: "Juniors",
                    featuredImage: UIImage(named: "juniorSC")!,
                    color: UIColor(red: 20/255.0, green: 20/255.0, blue: 20/255.0, alpha: 0.4)),
            
            Updates(title: "Sophomores",
                    featuredImage: UIImage(named: "sophSC")!,
                    color: UIColor(red: 20/255.0, green: 20/255.0, blue: 20/255.0, alpha: 0.4)),
            
            Updates(title: "Freshmen",
                    featuredImage: UIImage(named: "freshSC")!,
                    color: UIColor(red: 20/255.0, green: 20/255.0, blue: 20/255.0, alpha: 0.4)),
            **/
        ]
    }
}
