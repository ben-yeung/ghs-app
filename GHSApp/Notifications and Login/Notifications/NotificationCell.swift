//
//  NotificationCell.swift
//  GHSApp
//
//  Created by BY on 9/27/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//

import Foundation

import UIKit

class NotificationCell: UITableViewCell {
    
    @IBOutlet weak var notificationText: UITextView!
    @IBOutlet weak var dateContainer: UIView!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var day: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        notificationText.centerVertically()
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension UITextView {
    
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
    
}
