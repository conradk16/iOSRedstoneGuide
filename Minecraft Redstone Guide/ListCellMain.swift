//
//  ListCellMain.swift
//  Minecraft Redstone Guide
//
//  Created by Stefan Kuklinsky on 3/31/20.
//  Copyright © 2020 Stefan Kuklinsky. All rights reserved.
//

import Foundation
import UIKit

class ListCellMain: UITableViewCell {
    @IBOutlet weak var imgImageView: ScaledHeightImageView!
    @IBOutlet weak var nameLabel: Label!
    
    func setCell(img:UIImage, label:String) {
        
        if (!global.previouslyLoadedMainVC) {
            nameLabel.isHidden = true
        }
        
        imgImageView.contentMode = .scaleAspectFill
        imgImageView.layer.cornerRadius = 14.0
        imgImageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        imgImageView.layer.masksToBounds = true
        
        nameLabel.text = label
        imgImageView.image = img
    }
}
