//
//  CalendarTableViewCell.swift
//  GHSApp
//
//  Created by BY on 8/9/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//

import UIKit

class CalendarTableViewCell: UITableViewCell {

    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var dateContainer: UIView!
    @IBOutlet weak var dayOfWeek: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
