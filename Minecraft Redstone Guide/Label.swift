//
//  Label.swift
//  Minecraft Redstone Guide
//
//  Created by Stefan Kuklinsky on 3/31/20.
//  Copyright © 2020 Stefan Kuklinsky. All rights reserved.
//

import Foundation
import UIKit

class Label: UILabel {
    
    var tintedClearImage: UIImage?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    func setup() {
        //self.borderStyle = UITextField.BorderStyle.roundedRect
        self.layer.cornerRadius = 14.0
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.layer.masksToBounds = true
    }
}
