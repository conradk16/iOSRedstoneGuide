//
//  TrapsViewController.swift
//  Minecraft Redstone Guide
//
//  Created by Stefan Kuklinsky on 4/19/20.
//  Copyright © 2020 Stefan Kuklinsky. All rights reserved.
//

import GoogleMobileAds
import UIKit

class TrapsViewController: UIViewController, GADRewardedAdDelegate {

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var backImgView: UIImageView!
    
    var listEntryLabels:[String] = []
    var listEntryImages:[UIImage] = []
    
    var listOfSlideShowDescriptions:[[String]] = []
    var listOfSlideShowImageNames:[[String]] = []
    
    var locked:[Bool] = [false, true, false, false, true]
    var difficulties:[Int] = [2, 3, 3, 4, 4]
    
    var rowClickedForVideoAds:Int? = nil
    
    @IBAction func unwindToTrapsVC(segue: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 0...(locked.count - 1) {
            if locked[index] && global.trapsVideoProgress![index] as! Int >= global.numRewardedVideosRequired{
                locked[index] = false
            }
        }
        
        self.transitioningDelegate = self
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
                
        listEntryLabels.append("TNT Trap")
        listEntryLabels.append("Arrow Trap")
        listEntryLabels.append("Crusher")
        listEntryLabels.append("Lava Trap")
        listEntryLabels.append("Sand Trap")
        listEntryImages.append(UIImage(named: "tnt_trap_cover_img")!)
        listEntryImages.append(UIImage(named: "arrow_trap_cover_img")!)
        listEntryImages.append(UIImage(named: "crusher_cover_img")!)
        listEntryImages.append(UIImage(named: "lava_trap_cover_img")!)
        listEntryImages.append(UIImage(named: "sand_trap_cover_img")!)

        
        let crusherTrapD:[String] = ["Place items as shown. Set the redstone repeater to 1 tick.", "Make sure to use a regular piston instead of a sticky piston.", "Place a block of redstone in front of the piston.", "Set all redstone repeaters to 1 tick.", "Do the same on the other side.", "", "Place a trapped chest in front of the redstone repeater. Opening the chest will set off the trap and crush any player between the walls.", "To reset the trap. Move the block of redstone back to its original position."]
        let crusherTrapI:[String] = ["crusher_img_1", "crusher_img_2", "crusher_img_3", "crusher_img_4", "crusher_img_5", "crusher_img_6", "crusher_img_7", "crusher_img_8"]
        
        let lavaTrapD:[String] = ["Place sticky pistons and dig a 1 block deep hole as shown.", "Add blocks as shown and fill the hole with lava.", "", "", "", "Place a redstone torch and dust as shown. The sticky pistons on that side should all extend.", "Do the same on the other side.", "Place blocks in front of the sticky pistons. Then attach tripwire hooks to the blocks under the redstone torches as shown. Lastly, place string on all blocks between the tripwire hooks. You should hear a click when the last string is placed. This means the tripwire is now active.", "The string is hard to see, but if you point your cursor at it you should be able to see a small hitbox.", "Place more blocks to extend the hallway.", "Build walls and cover the hallway.", "Poke a few holes in the sides so the tripwire hole is less suspicious."]
        let lavaTrapI:[String] = ["lava_trap_img_1", "lava_trap_img_2", "lava_trap_img_3", "lava_trap_img_4", "lava_trap_img_5", "lava_trap_img_6", "lava_trap_img_7", "lava_trap_img_8", "lava_trap_img_9", "lava_trap_img_10", "lava_trap_img_11", "lava_trap_img_12"]

        let sandTrapD:[String] = ["Place blocks as shown. If you are having trouble placing the sticky pistons, try placing temporary blocks behind them first.", "", "", "Set the redstone repeater to 2 ticks. Make sure to place a dropper instead of a dispenser.", "Place a hopper facing into the dropper. To place the hopper without opening the dropper, crouch while placing it.", "Make sure to place a piece of redstone dust on top of the hopper. Again, you will need to crouch while placing it to avoid opening the hopper.", "The sticky pistons should all extend on this step.", "Place a redstone repeater (set it to 1 tick) and place 4 blocks in an upside-down \"L\" shape.", "Add blocks to close the hole.", "Place a trapped chest. Opening the chest opens the ceiling if it's closed, and closes the ceiling if it's open.", "Place sand 5 blocks high (or more) on top of the ceiling. Now when the chest is opened, the sand will fall, suffocating any players inside."]
        let sandTrapI:[String] = ["sand_trap_img_1", "sand_trap_img_2", "sand_trap_img_3", "sand_trap_img_4", "sand_trap_img_5", "sand_trap_img_6", "sand_trap_img_7", "sand_trap_img_8", "sand_trap_img_8", "sand_trap_img_10", "sand_trap_img_11"]
        
        let tntTrapD:[String] = ["Place blocks, TNT, and redstone dust as shown.", "Place blocks above the TNT.", "Place more blocks.", "Place tripwire hooks and 4 pieces of string between them.", "The string is difficult to see. Walking past the string will trigger the TNT.", "Cover the walkway."]
        let tntTrapI:[String] = ["tnt_trap_img_1","tnt_trap_img_2", "tnt_trap_img_3", "tnt_trap_img_4", "tnt_trap_img_5", "tnt_trap_img_6"]
        
        let arrowTrapD:[String] = ["Place blocks and dispensers as shown.", "Place blocks as shown. Leave a 1 block high gap for the arrows to come through.", "Do the same on the other side.", "Build walls higher and add a ceiling.", "Place a redstone repeater in the gap inside the room. Set the redstone repeater to 1 tick.", "Place blocks and a regular piston facing upward.", "Place redstone components as shown. Set the comparator to subtract mode (front torch on).", "Place redstone dust and a redstone repeater on the other side. Set the redstone repeater to 1 tick.", "Place a stack of arrows inside each dispenser.", "Place a trapped chest inside the room. Opening the chest will trigger the trap.", "To reset the trap, destroy the block of redstone and place it back in its original place."]
        let arrowTrapI:[String] = ["arrow_trap_img_1", "arrow_trap_img_2", "arrow_trap_img_3", "arrow_trap_img_4", "arrow_trap_img_5", "arrow_trap_img_6", "arrow_trap_img_7", "arrow_trap_img_8", "arrow_trap_img_9", "arrow_trap_img_10", "arrow_trap_img_11"]
        
        listOfSlideShowDescriptions.append(tntTrapD)
        listOfSlideShowDescriptions.append(arrowTrapD)
        listOfSlideShowDescriptions.append(crusherTrapD)
        listOfSlideShowDescriptions.append(lavaTrapD)
        listOfSlideShowDescriptions.append(sandTrapD)
        
        listOfSlideShowImageNames.append(tntTrapI)
        listOfSlideShowImageNames.append(arrowTrapI)
        listOfSlideShowImageNames.append(crusherTrapI)
        listOfSlideShowImageNames.append(lavaTrapI)
        listOfSlideShowImageNames.append(sandTrapI)


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
        let progress:Int = global.trapsVideoProgress![row] as! Int + 1
        global.trapsVideoProgress?[row] = progress
        UserDefaults.standard.set(global.trapsVideoProgress, forKey: "trapsVideoProgress")
        if global.trapsVideoProgress?[row] as! Int == global.numRewardedVideosRequired {
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

extension TrapsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listEntryLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "listCellTraps") as! ListCellTraps
        cell.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 255/255)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        let isLocked = !(global.fullVersion || !locked[indexPath.row])
        
        cell.setCell(img: listEntryImages[indexPath.row], label: listEntryLabels[indexPath.row], isLocked: isLocked, difficulty: difficulties[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        if (!global.fullVersion && locked[indexPath.row]) {
            var alert:UIAlertController
            let remainingVids = global.numRewardedVideosRequired - (global.trapsVideoProgress![indexPath.row] as! Int)
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
        newScreen.senderVCIdentifier = "unwindToTrapsVC"
        
        newScreen.modalPresentationStyle = .fullScreen
        self.present(newScreen, animated: true, completion: nil)
        
    }
}

extension TrapsViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(animationDuration: global.ANIMATION_DURATION, animationType: .present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(animationDuration: global.ANIMATION_DURATION, animationType: .dismiss)
    }
}
