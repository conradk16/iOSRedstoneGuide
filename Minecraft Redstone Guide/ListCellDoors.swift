//
//  ListCellDoors.swift
//  Minecraft Redstone Guide
//
//  Created by Stefan Kuklinsky on 4/12/20.
//  Copyright © 2020 Stefan Kuklinsky. All rights reserved.
//

import Foundation
import UIKit

class ListCellDoors: UITableViewCell {
    
    @IBOutlet weak var imgImageView: ScaledHeightImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lockIcon: UIImageView!
    @IBOutlet weak var rs1: UIImageView!
    @IBOutlet weak var rs2: UIImageView!
    @IBOutlet weak var rs3: UIImageView!
    @IBOutlet weak var rs4: UIImageView!
    @IBOutlet weak var rs5: UIImageView!
    
    func setCell(img:UIImage, label:String, isLocked:Bool, difficulty:Int) {
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
        
        if difficulty >= 1 {
            rs1.image = UIImage(named: "rating_star_filled")!
        } else {
            rs1.image = UIImage(named: "rating_star_empty")!
        }
        
        if difficulty >= 2 {
            rs2.image = UIImage(named: "rating_star_filled")!
        } else {
            rs2.image = UIImage(named: "rating_star_empty")!
        }
        
        if difficulty >= 3 {
            rs3.image = UIImage(named: "rating_star_filled")!
        } else {
            rs3.image = UIImage(named: "rating_star_empty")!
        }
        
        if difficulty >= 4 {
            rs4.image = UIImage(named: "rating_star_filled")!
        } else {
            rs4.image = UIImage(named: "rating_star_empty")!
        }
        
        if difficulty >= 5 {
            rs5.image = UIImage(named: "rating_star_filled")!
        } else {
            rs5.image = UIImage(named: "rating_star_empty")!
        }
        
    }
    
}
