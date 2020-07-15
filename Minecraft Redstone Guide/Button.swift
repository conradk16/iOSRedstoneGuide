//
//  Button.swift
//  Minecraft Redstone Guide
//
//  Created by Stefan Kuklinsky on 3/31/20.
//  Copyright © 2020 Stefan Kuklinsky. All rights reserved.
//

import Foundation
import UIKit

class Button: UIButton {
    
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
        self.layer.masksToBounds = true
        self.layer.borderWidth = 2.0
        let borderColor:UIColor = UIColor.init(red: 233/255, green: 233/255, blue: 233/255, alpha: 1)
        self.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        self.layer.borderColor = borderColor.cgColor
    }
}

