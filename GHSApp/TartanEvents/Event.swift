//
//  Event.swift
//  GHSApp
//
//  Created by BY on 8/9/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//

import UIKit

class Events: Codable {
    let event: [Event]
    
    init(Events: [Event]) {
        self.event = Events
    }
}

class Event: Codable {
    
    let title : String
    let description : String
    let start : String
    let end : String
    
    init(title: String, description: String, start: String, end: String) {
        
        self.title = title
        self.description = description
        self.start = start
        self.end = end
        
    }

}
