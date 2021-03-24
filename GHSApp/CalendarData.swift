//
//  CalendarData.swift
//  GHSApp
//
//  Created by BY on 8/9/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//

import Foundation

class CalendarData {
    
        let profileImageURL : String
        let fullName : String
        let location : String
        let title : String
        let postTime : String
        let likes : Int
        let comments : Int
        let mediaType : String
        let contentURL : String
        let content : String
        let plocation : String
        
        
        init(postDict : [String:Any])
        {
            fullName = postDict["full_name"] as? String ?? ""
            profileImageURL = postDict["profile_pic"] as? String ?? ""
            location = postDict["user_city"] as? String ?? ""
            title = postDict["title"] as? String ?? ""
            postTime = postDict["order_by_date"] as? String ?? ""
            likes = postDict["liked_count"] as? Int ?? 0
            comments = postDict["comment_count"] as? Int ?? 0
            mediaType = postDict["media_path"] as? String ?? ""
            contentURL = postDict["media_path"] as? String ?? ""
            content = postDict["content"] as? String ?? ""
            plocation = postDict["location"] as? String ?? ""
        
        }
}
