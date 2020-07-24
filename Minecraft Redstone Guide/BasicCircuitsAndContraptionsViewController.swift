//
//  BasicCircuitsAndContraptionsViewController.swift
//  Minecraft Redstone Guide
//
//  Created by Stefan Kuklinsky on 4/1/20.
//  Copyright © 2020 Stefan Kuklinsky. All rights reserved.
//

import GoogleMobileAds
import UIKit

class BasicCircuitsAndContraptionsViewController: UIViewController, GADRewardedAdDelegate {
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var backImgView: UIImageView!
    
    var listEntryLabels:[String] = []
    var listEntryImages:[UIImage] = []
    
    var listOfSlideShowDescriptions:[[String]] = []
    var listOfSlideShowImageNames:[[String]] = []
    
    var locked:[Bool] = [false, false, false, false, false, false, false, false, false, false, false]
    
    var rowClickedForVideoAds:Int? = nil
    
    @IBAction func unwindToBCACVC(segue: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 0...(locked.count - 1) {
            if locked[index] && global.bcacVideoProgress![index] as! Int >= global.numRewardedVideosRequired{
                locked[index] = false
            }
        }
        
        self.transitioningDelegate = self
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        listEntryLabels.append("NOT Gate")
        listEntryLabels.append("OR Gate")
        listEntryLabels.append("AND Gate")
        listEntryLabels.append("NOR Gate")
        listEntryLabels.append("NOT AND Gate")
        listEntryLabels.append("Basic Clock")
        listEntryLabels.append("Compact Clock")
        listEntryLabels.append("Super Fast Clock")
        listEntryLabels.append("Button as a Switch")
        listEntryLabels.append("Circuit Breaker")
        listEntryLabels.append("Double Sticky Pison")
        listEntryImages.append(UIImage(named: "not_gate_cover_img")!)
        listEntryImages.append(UIImage(named: "or_gate_cover_img")!)
        listEntryImages.append(UIImage(named: "and_gate_cover_img")!)
        listEntryImages.append(UIImage(named: "nor_gate_cover_img")!)
        listEntryImages.append(UIImage(named: "not_and_gate_cover_img")!)
        listEntryImages.append(UIImage(named: "basic_clock_cover_img")!)
        listEntryImages.append(UIImage(named: "compact_clock_cover_img")!)
        listEntryImages.append(UIImage(named: "super_fast_clock_cover_img")!)
        listEntryImages.append(UIImage(named: "button_as_a_switch_cover_img")!)
        listEntryImages.append(UIImage(named: "circuit_breaker_cover_img")!)
        listEntryImages.append(UIImage(named: "double_sticky_piston_cover_img")!)
        
        let notGateDescriptionSS:[String] = ["A redstone torch attached to a block inverts a signal.", ""]
        listOfSlideShowDescriptions.append(notGateDescriptionSS)
        let notGateImageSS:[String] = ["not_gate_img_1", "not_gate_img_2"]
        listOfSlideShowImageNames.append(notGateImageSS)
        
        let orGateDescriptionSS:[String] = ["A signal is transmitted when either power source is active.", ""]
        listOfSlideShowDescriptions.append(orGateDescriptionSS)
        let orGateImageSS:[String] = ["or_gate_img_1", "or_gate_img_2"]
        listOfSlideShowImageNames.append(orGateImageSS)
        
        let andGateDescriptionSS:[String] = ["A signal is transmitted when both power sources are active.", ""]
        listOfSlideShowDescriptions.append(andGateDescriptionSS)
        let andGateImageSS:[String] = ["and_gate_img_1", "and_gate_img_2"]
        listOfSlideShowImageNames.append(andGateImageSS)
        
        let norGateDescriptionSS:[String] = ["A signal is transmitted when neither input is active.", ""]
        listOfSlideShowDescriptions.append(norGateDescriptionSS)
        let norGateImageSS:[String] = ["nor_gate_img_1", "nor_gate_img_2"]
        listOfSlideShowImageNames.append(norGateImageSS)
        
        let notAndGateDescriptionSS:[String] = ["A signal is transmitted in all cases except when both power sources are active.", ""]
        listOfSlideShowDescriptions.append(notAndGateDescriptionSS)
        let notAndGateImageSS:[String] = ["not_and_gate_img_1", "not_and_gate_img_2"]
        listOfSlideShowImageNames.append(notAndGateImageSS)
        
        let basicClockDescriptionSS:[String] = ["A clock generates a repeating redstone signal. To build, set up the repeaters and redstone as shown, and set the delays on the repeaters. Increasing the delays will make the clock go slower.", "To start the clock, place a redstone torch next to one of the pieces of redstone dust and quickly remove it."]
        listOfSlideShowDescriptions.append(basicClockDescriptionSS)
        let basicClockImageSS:[String] = ["basic_clock_img_1", "basic_clock_img_2"]
        listOfSlideShowImageNames.append(basicClockImageSS)
        
        let compactClockDescriptionSS:[String] = ["Place blocks as shown. Set the repeater to at least the second level to keep the clock from burning out. Place the torch last."]
        listOfSlideShowDescriptions.append(compactClockDescriptionSS)
        let compactClockImageSS:[String] = ["compact_clock_img_1"]
        listOfSlideShowImageNames.append(compactClockImageSS)
        
        let superFastClockDescriotionSS:[String] = ["Place blocks as shown. Turn the comparator to subtract mode (front torch on), then turn on the lever."]
        listOfSlideShowDescriptions.append(superFastClockDescriotionSS)
        let superFastClockImageSS:[String] = ["super_fast_clock_img_1"]
        listOfSlideShowImageNames.append(superFastClockImageSS)
        
        let buttonAsASwitchDescriptionSS:[String] = ["This circuit uses a pulse to switch the output signal on and off.", "Place a dropper and hopper facing into each other. To place the hopper facing the dropper without opening the dropper, crouch while placing the hopper.", "Place blocks and redstone components as shown. Set the redstone repeater to 2 ticks. To place the redstone dust on the hopper, crouch while placing it."]
        listOfSlideShowDescriptions.append(buttonAsASwitchDescriptionSS)
        let buttonAsASwitchImageSS:[String] = ["button_as_a_switch_img_1", "button_as_a_switch_img_2", "button_as_a_switch_img_3"]
        listOfSlideShowImageNames.append(buttonAsASwitchImageSS)
        
        let circuitBreakerDescriptionSS:[String] = ["This device allows a redstone signal to be cut off by another redstone signal. Make sure to use a sticky piston instead of a regular piston.", ""]
        listOfSlideShowDescriptions.append(circuitBreakerDescriptionSS)
        let circuitBreakerImageSS:[String] = ["circuit_breaker_img_1", "circuit_breaker_img_2"]
        listOfSlideShowImageNames.append(circuitBreakerImageSS)
        
        let doubleStickyPistonDescriptionSS:[String] = ["This can be used to push and pull blocks 2 spaces instead of 1. Place the items as shown, with all redstone repeaters set to a delay of 4.", ""]
        listOfSlideShowDescriptions.append(doubleStickyPistonDescriptionSS)
        let doubleStickyPistonImageSS:[String] = ["double_sticky_piston_img_1", "double_sticky_piston_img_2"]
        listOfSlideShowImageNames.append(doubleStickyPistonImageSS)

        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.separatorStyle = .none
        mainLabel.backgroundColor = UIColor.init(red: 226/255, green: 56/255, blue: 56/255, alpha: 255/255)
        self.view.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 255/255)
        listTableView.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 255/255)
        backImgView.image = UIImage(named: "back")
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(backBtnTapDetected))
        backImgView.isUserInteractionEnabled = true
        backImgView.addGestureRecognizer(singleTap)
        
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor.init(red: 226/255, green: 56/255, blue: 56/255, alpha: 255/255)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
    }
    
    //Action
    @objc func backBtnTapDetected() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                self.dismiss(animated: true, completion: nil)
            case UISwipeGestureRecognizer.Direction.down:
                print("Swiped down")
            case UISwipeGestureRecognizer.Direction.left:
                print("Swiped left")
            case UISwipeGestureRecognizer.Direction.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
    func clickedWatchVideo(row:Int) {
        rowClickedForVideoAds = row
        let success:Bool = global.showAdAndReloadRewardedVideo(rootViewController: self)
        
        if !success {
            global.popUpForUnableToLoadAd(rootViewController: self)
            return
        }
    }
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        let row:Int = rowClickedForVideoAds!
        let progress:Int = global.bcacVideoProgress![row] as! Int + 1
        global.bcacVideoProgress?[row] = progress
        UserDefaults.standard.set(global.bcacVideoProgress, forKey: "bcacVideoProgress")
        if global.bcacVideoProgress?[row] as! Int == global.numRewardedVideosRequired {
            locked[row] = false
            self.listTableView.reloadData()
        }
    }
    
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
        global.loadNewRewardedVideoAd()
    }
    
    func upgradeClicked() {
        global.groupFetch.enter()
        let authorized = StoreObserver.shared.fetchProducts()
        if !authorized {
            let alert = UIAlertController(title: "User is not authorized to purchase", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        global.groupFetch.notify(queue: .main) { //done fetching
            if StoreObserver.shared.availableProducts.count > 0 {
                global.groupBuy.enter()
                StoreObserver.shared.buy(StoreObserver.shared.availableProducts[0])
                global.groupBuy.notify(queue: .main) { //done buying
                    if global.couldNotConnectToItunesPurchasing {
                        let alert = UIAlertController(title: "Could not connect to iTunes store", message: "Please try again later", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        global.couldNotConnectToItunesPurchasing = false
                    } else if (global.fullVersion) {
                        self.listTableView.reloadData()
                    }
                }
            } else { //could not fetch
                let alert = UIAlertController(title: "Could not connect to iTunes store", message: "Please try again later", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

}

extension BasicCircuitsAndContraptionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listEntryLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "listCellBCAC") as! ListCellBCAC
        cell.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 255/255)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let isLocked = !(global.fullVersion || !locked[indexPath.row])
        cell.setCell(img: listEntryImages[indexPath.row], label: listEntryLabels[indexPath.row], isLocked: isLocked)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        if (!global.fullVersion && locked[indexPath.row]) {
            var alert:UIAlertController
            let remainingVids = global.numRewardedVideosRequired - (global.bcacVideoProgress![indexPath.row] as! Int)
            alert = UIAlertController(title: "Watch Videos or Upgrade to Unlock", message: "Watch two short videos to unlock (" + String(remainingVids) + " remaining), or upgrade to the Full Version to remove ads and unlock all content.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Watch Video", style: .default, handler: { action in
                self.clickedWatchVideo(row:indexPath.row)
            }))
            alert.addAction(UIAlertAction(title: "Upgrade", style: .default, handler: { action in
                self.upgradeClicked()
            }))
            alert.addAction(UIAlertAction(title: "No thanks", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        let newScreen = self.storyboard?.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
        newScreen.slideShowName = listEntryLabels[indexPath.row]
        newScreen.listOfDescriptions = listOfSlideShowDescriptions[indexPath.row]
        newScreen.listOfImageNames = listOfSlideShowImageNames[indexPath.row]
        newScreen.senderVCIdentifier = "unwindToBCACVC"
        
        newScreen.modalPresentationStyle = .fullScreen
        self.present(newScreen, animated: true, completion: nil)
        
    }
}

extension BasicCircuitsAndContraptionsViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(animationDuration: global.ANIMATION_DURATION, animationType: .present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(animationDuration: global.ANIMATION_DURATION, animationType: .dismiss)
    }
    
    
}
