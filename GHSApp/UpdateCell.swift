//
//  UpdateCell.swift
//  GHSApp
//
//  Created by BY on 12/1/18.
//  Copyright © 2018 GHSAppClub. All rights reserved.
//

import UIKit

class UpdateCell: UICollectionViewCell
{
    
    @IBOutlet weak var featuredImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var version: Updates? {
        didSet {
            self.updateUI()
        }
    }
    
    private func updateUI()
    {
        if let version = version {
            
            featuredImage.image = version.featuredImage
            featuredImage.contentMode = UIViewContentMode.scaleAspectFit
            nameLabel.text = version.title
            
        } else {
            
            featuredImage.image = nil
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 3.0
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 5, height: 10)
        
        self.clipsToBounds = false
    }
}
