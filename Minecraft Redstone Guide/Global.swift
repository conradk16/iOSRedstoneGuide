//
//  Global.swift
//  Minecraft Redstone Guide
//
//  Created by Stefan Kuklinsky on 4/2/20.
//  Copyright © 2020 Stefan Kuklinsky. All rights reserved.
//

import Foundation
import QuartzCore
import StoreKit
import SystemConfiguration
import GoogleMobileAds

class Global {
    
    var width:CGFloat = 0
    var previouslyLoadedMainVC = false
    var ANIMATION_DURATION:Double = 0.3
    
    var actionCountForReview = UserDefaults.standard.integer(forKey: "actionCountForReview") //zero if nothing stored
    var currentThreshold = UserDefaults.standard.integer(forKey: "currentThreshold") //zero if nothing stored
    let initialThreshold:Int = 30
    
    var fullVersion:Bool = false
    let groupRestore = DispatchGroup()
    let groupFetch = DispatchGroup()
    let groupBuy = DispatchGroup()
    var didConnectToItunes:Bool = true
    var couldNotConnectToItunesPurchasing:Bool = false
    
    var interstitial: GADInterstitial!
    var personalizedAds = UserDefaults.standard.integer(forKey: "personalizedAds") //zero if nothing stored
    //personalized ads: 0 means not chosen; 1 means personalized in EEA; 2 means not personalized, 5 means not in EEA so no choice - personalized
    var timeOpenedOrLastAdShown:Int = 0
    let MIN_TIME_BETWEEN_ADS:Int = 60 // in seconds
    
    
    var paidForApp = UserDefaults.standard.bool(forKey: "paidForApp") // false if nothing stored
    
    func saveIAP(didPurchase:Bool) {
        do {
            global.fullVersion = didPurchase
            let purchaseStatus = IAP(didPurchase: didPurchase)
            let purchaseData = try NSKeyedArchiver.archivedData(withRootObject: purchaseStatus, requiringSecureCoding: false)
            UserDefaults.standard.set(purchaseData, forKey: "purchaseSettings")
        } catch {
            print("could not write")
        }
    }
    
    func loadIAP() -> Bool? {
        do {
            guard let purchaseData = UserDefaults.standard.data(forKey: "purchaseSettings"),
                let didPurchase = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(purchaseData) as? IAP else {return nil}
            return didPurchase.purchased
        }catch {
            print("couldnt load")
        }
        return nil
    }
    
    //Stack Overflow magic
    func isConnectedToInternet() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        if flags.isEmpty {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    func timeToAskForReview() -> Bool {
        let count = UserDefaults.standard.integer(forKey: "actionCountForReview")
        var currentThreshold = UserDefaults.standard.integer(forKey: "currentThreshold")
        if currentThreshold == 0 { //nothing previously stored
            currentThreshold = initialThreshold
            UserDefaults.standard.set(currentThreshold, forKey: "currentThreshold")
        }
        if count >= currentThreshold {
            return true
        } else {
            return false
        }
    }
    
    func updateCurrentThreshold() {
        currentThreshold = UserDefaults.standard.integer(forKey: "currentThreshold")
        currentThreshold = currentThreshold * 2
        UserDefaults.standard.set(currentThreshold, forKey: "currentThreshold")
    }
    
    func addToActionCountForReview(numToBeAdded:Int) {
        let currentCount = UserDefaults.standard.integer(forKey: "actionCountForReview")
        UserDefaults.standard.set(currentCount + numToBeAdded, forKey: "actionCountForReview")
    }
    
    func loadNewInterstitialAd() {
        global.interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910") // TEST AD ID
        //global.interstitial = GADInterstitial(adUnitID: "ca-app-pub-6860445609360439/9184873964") // REAL AD ID
        
        let request = GADRequest()
        
        if (personalizedAds != 1 && personalizedAds != 5) { // if in EEA and did not consent to personalized ads
            let extras = GADExtras()
            extras.additionalParameters = ["npa": "1"]
            request.register(extras)
        }
        
        interstitial.load(request)
    }
    
    func showAdAndReloadInterstitial(rootViewController: UIViewController) {
        if (interstitial == nil) {
            loadNewInterstitialAd()
        }
        if interstitial.isReady {
            interstitial.present(fromRootViewController: rootViewController)
            timeOpenedOrLastAdShown = Int(Date().timeIntervalSinceReferenceDate)
            loadNewInterstitialAd()
        } else {
            print("Ad wasn't ready")
        }
    }
    
    func shouldShowInterstitial() -> Bool {
        
        if (fullVersion || timeToAskForReview()) {
            return false
        }
        
        if (Int(Date().timeIntervalSinceReferenceDate) - timeOpenedOrLastAdShown > MIN_TIME_BETWEEN_ADS) {
            return true
        }

        return false
    }
    
}

let global = Global()
