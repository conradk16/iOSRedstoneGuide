//
//  ListCellBCAC.swift
//  Minecraft Redstone Guide
//
//  Created by Stefan Kuklinsky on 4/1/20.
//  Copyright © 2020 Stefan Kuklinsky. All rights reserved.
//

import Foundation
import UIKit

class ListCellBCAC: UITableViewCell {
    
    @IBOutlet weak var imgImageView: ScaledHeightImageView!
    @IBOutlet weak var nameLabel: Label!
    @IBOutlet weak var lockIcon: UIImageView!
    
    
    func setCell(img:UIImage, label:String, isLocked:Bool) {
        imgImageView.contentMode = .scaleAspectFill
        imgImageView.layer.cornerRadius = 14.0
        imgImageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        imgImageView.layer.masksToBounds = true
        
        nameLabel.text = label
        imgImageView.image = img
        
        if isLocked {
            lockIcon.image = UIImage(named: "lock_icon")!
        } else {
            lockIcon.image = nil
        }
        
    }
    
}
