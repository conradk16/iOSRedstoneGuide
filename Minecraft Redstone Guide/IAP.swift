//
//  IAP.swift
//  Minecraft Redstone Guide
//
//  Created by Stefan Kuklinsky on 4/2/20.
//  Copyright © 2020 Stefan Kuklinsky. All rights reserved.
//

import Foundation

class IAP: NSObject, NSCoding {
    var purchased:Bool?
    
    init(didPurchase:Bool) {
        self.purchased = didPurchase
    }
    
    required init(coder decoder: NSCoder) {
        purchased = decoder.decodeObject(forKey: "didPurchase") as? Bool
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(purchased, forKey: "didPurchase")
    }
}
