//
//  ScaledHeightImageView.swift
//  Minecraft Redstone Guide
//
//  Created by Stefan Kuklinsky on 3/31/20.
//  Copyright © 2020 Stefan Kuklinsky. All rights reserved.
//

import Foundation
import UIKit

class ScaledHeightImageView: UIImageView {
    
    override var intrinsicContentSize: CGSize {
        
        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = global.width

            let ratio = myViewWidth/myImageWidth
            var scaledHeight = myImageHeight * ratio
            
            if (global.width > 500 && myImageHeight > 500) { // if on larger device and on infoScreen
                scaledHeight = scaledHeight - 100
            }

            return CGSize(width: myViewWidth, height: scaledHeight)
        }

        return CGSize(width: -1.0, height: -1.0)
 
    }
}
