//
//  DoorsViewController.swift
//  Minecraft Redstone Guide
//
//  Created by Stefan Kuklinsky on 4/12/20.
//  Copyright © 2020 Stefan Kuklinsky. All rights reserved.
//

import UIKit

class DoorsViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var backImgView: UIImageView!
    
    var listEntryLabels:[String] = []
    var listEntryImages:[UIImage] = []
    
    var listOfSlideShowDescriptions:[[String]] = []
    var listOfSlideShowImageNames:[[String]] = []
    
    var locked:[Bool] = [false, false, false, true, false, false, true]
    var difficulties:[Int] = [2, 3, 3, 4, 4, 5, 5]
    
    @IBAction func unwindToDoorsVC(segue: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.transitioningDelegate = self
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
                
        listEntryLabels.append("Button 2x2 Piston Door")
        listEntryLabels.append("Pressure Plate 2x2 Piston")
        listEntryLabels.append("Pressure Plate Double Door")
        listEntryLabels.append("Flush Piston Door")
        listEntryLabels.append("Flush Basement Door")
        listEntryLabels.append("3x3 Door (Java Only)")
        listEntryLabels.append("Ceiling Door")
        listEntryImages.append(UIImage(named: "button_2x2_piston_door_cover_img")!)
        listEntryImages.append(UIImage(named: "pressure_plate_2x2_piston_door_cover_img")!)
        listEntryImages.append(UIImage(named: "pressure_plate_double_door_cover_img")!)
        listEntryImages.append(UIImage(named: "flush_piston_door_cover_img")!)
        listEntryImages.append(UIImage(named: "flush_basement_door_cover_img")!)
        listEntryImages.append(UIImage(named: "piston_door_3x3_cover_img")!)
        listEntryImages.append(UIImage(named: "ceiling_door_cover_img")!)
        
        let button2x2PistonDoorDescriptionSS:[String] = ["Place blocks as shown. Make sure to use sticky pistons instead of regular pistons.", "", "Make sure to set the redstone repeater to 2 ticks.", "Set both new redstone repeaters to 1 tick.", "Place a button on the other side.", "Add blocks to cover up the pistons."]
        let button2x2PistonDoorImageSS:[String] = ["button_2x2_piston_door_img_1", "button_2x2_piston_door_img_2", "button_2x2_piston_door_img_3", "button_2x2_piston_door_img_4", "button_2x2_piston_door_img_5", "button_2x2_piston_door_img_6"]
        
        let flushPistonDoorDescriptionSS:[String] = ["Dig a 3 deep, 14 by 8 hole, and place items as shown. Make sure to set both redstone repeaters to 1 tick.", "Make sure to set the new redstone repeater to 1 tick.", "Do the same on the other side.", "Cover the hole except for a 2 block slot on each side. Set each of the new redstone repeaters to 3 ticks.", "Do the same on the other side.", "Bring the redstone signal upward with slabs. Set both new redstone repeaters to 3 ticks. If you are having trouble placing the slabs, try placing temporary blocks behind them first.", "Do the same thing on the other side.", "Add the new blocks and redstone dust only to the right side. Make sure not to miss the additional slab on the right.", "Place four sticky pistons facing right, four facing left, and two facing forward. All should immediately extend.", "Add the last two sticky pistons. These should also immediately extend.", "Cover the front completely and place the button as shown. Pressing the button should briefly open the door for you to walk through.", "Cover the back, leaving a 2x2 gap to walk through. Place another button as shown."]
        let flushPistonDoorImageSS:[String] = ["flush_piston_door_img_1", "flush_piston_door_img_2", "flush_piston_door_img_3", "flush_piston_door_img_4", "flush_piston_door_img_5", "flush_piston_door_img_6", "flush_piston_door_img_7", "flush_piston_door_img_8", "flush_piston_door_img_9", "flush_piston_door_img_10", "flush_piston_door_img_11", "flush_piston_door_img_11"]

        let pressurePlate2x2PistonDoorDescriptionSS:[String] = ["Dig a 10x7, 3 block deep hole.", "Place blocks as shown.", "Add torches and a piece of redstone dust.", "Do the same on the other side.", "Cover the hole.", "Place blocks as shown. Make sure to use sticky pistons instead of regular pistons.", "Add redstone dust and pressure plates.", "Cover the pistons."]
        let pressurePlate2x2PistonDoorImageSS:[String] = ["pressure_plate_2x2_piston_door_img_1", "pressure_plate_2x2_piston_door_img_2", "pressure_plate_2x2_piston_door_img_3", "pressure_plate_2x2_piston_door_img_4", "pressure_plate_2x2_piston_door_img_5", "pressure_plate_2x2_piston_door_img_6", "pressure_plate_2x2_piston_door_img_7", "pressure_plate_2x2_piston_door_img_8"]
        
        let pressurePlateDoubleDoorDescriptionSS:[String] = ["Dig a 10x9, 3 block deep hole.", "Place blocks as shown.", "Add restone dust and torches.", "Cover the hole.", "Add doors and pressure plates.", "Cover the doors."]
        let pressurePlateDoubleDoorImageSS:[String] = ["pressure_plate_double_door_img_1", "pressure_plate_double_door_img_2", "pressure_plate_double_door_img_3", "pressure_plate_double_door_img_4", "pressure_plate_double_door_img_5" ,"pressure_plate_double_door_img_5"]
        
        let piston3x3:[String] = ["Warning: Only for Java Edition! Do not build if you are not playing Minecraft on a computer. Dig a 2 deep, 11 by 8 hole and place items as shown. Set the left redstone repeater to 2 ticks, the middle repeater to 4 ticks, and the right repeater to 3 ticks.", "Place observers. Make sure they are each facing the correct direction. You can see which way they're facing from the arrow on top.", "Set each new redstone repeater to 1 tick.", "Make sure the dropper and hopper face into each other. To place the hopper without opening the dropper, crouch while placing it.", "Place a single item into the dropper.", "Place 3 sticky pistons as shown. You will need to dig 1 additional block deep to place the bottom sticky piston.", "Place another dropper and hopper facing into each other. Again, you will need to crouch while placing the hopper so the dropper doesn't open.", "Place a single item into the new dropper.", "Make sure to use sticky pistons instead of regular pistons.", "", "Set both new redstone repeaters to 1 tick.", "", "Fill in the walls and ceiling, and add levers as shown."]
        let piston3x3Images:[String] = ["piston_door_3x3_img_1", "piston_door_3x3_img_2", "piston_door_3x3_img_3", "piston_door_3x3_img_4", "piston_door_3x3_img_5", "piston_door_3x3_img_6", "piston_door_3x3_img_7", "piston_door_3x3_img_8", "piston_door_3x3_img_9", "piston_door_3x3_img_10", "piston_door_3x3_img_11", "piston_door_3x3_img_12", "piston_door_3x3_img_13"]
        
        let ceiling:[String] = ["Dig a 2 block deep hole and place blocks as shown. Set both redstone repeaters to 4 ticks.", "Add more blocks and a piece of redstone dust at the bottom. Place a slime block on top of the sticky piston.", "", "", "If you're having trouble placing the sticky pistons, place temporary scaffolding blocks behind them first.", "These next 4 pistons are also sticky pistons.", "", "", "Repeat the previous step on the other side.", "Make sure to place a dropper (not a dispenser). Set both outward facing redstone repeaters to 2 ticks, and set the third repeater to 1 tick.", "Of the 6 new redstone repeaters, four should be set to 4 ticks, and two should be set to 1 tick.", "Place a hopper facing into the dropper. To place the hopper without opening the dropper, crouch while placing it.", "Make sure to place a piece of redstone dust on top of the hopper. Again, you will need to crouch while placing it to avoid opening the hopper.", "Place a single item into the hopper.", "Move to the back of the structure and place blocks and redstone as shown.", "If you are having trouble placing slabs, try placing temporary blocks behind them first.", "", "Place a button inside the hallway. Pressing this should open the door briefly so you can jump down.", "Add water and place another button. Stand on the slime block and press the button to be launched upward. After getting launched, move forward into the hallway above. Make sure to wait for the door to close behind you before pressing the other button to go back down. If you press the other button too soon, the door may get out of sync, and the buttons will close the door instead of opening it.", "If the door gets out of sync, you can fix it by moving the item from the dropper back to the hopper."]
        let ceilingImages:[String] = ["ceiling_door_img_1", "ceiling_door_img_2", "ceiling_door_img_3", "ceiling_door_img_4", "ceiling_door_img_5", "ceiling_door_img_6", "ceiling_door_img_7", "ceiling_door_img_8", "ceiling_door_img_9", "ceiling_door_img_10", "ceiling_door_img_11", "ceiling_door_img_12", "ceiling_door_img_13", "ceiling_door_img_14", "ceiling_door_img_15", "ceiling_door_img_16", "ceiling_door_img_17", "ceiling_door_img_18", "ceiling_door_img_19", "ceiling_door_img_20"]
        
        let flushBasement:[String] = ["Dig a 3 deep, 10 by 14 hole and place blocks as shown.", "Place sticky pistons.", "", "Add redstone dust and repeaters. Ticks for the lower level repeaters, from left to right: 1, 4, 2, 2, 4, 1. The repeaters behind the pistons should both be set to 3 ticks.", "Add more redstone dust and repeaters on the other side. Ticks for the lower level repeaters, from left to right: 3, 1, 1, 3. The repeaters behind the pistons should both be set to 3 ticks.", "Build up the walls of the hole, and place a lever.", "Add more blocks to the floor. Flicking the lever will open and close the door."]
        let flushBasementImages:[String] = ["flush_basement_door_img_1", "flush_basement_door_img_2", "flush_basement_door_img_3", "flush_basement_door_img_4", "flush_basement_door_img_5", "flush_basement_door_img_6", "flush_basement_door_img_7"]

        listOfSlideShowDescriptions.append(button2x2PistonDoorDescriptionSS)
        listOfSlideShowDescriptions.append(pressurePlate2x2PistonDoorDescriptionSS)
        listOfSlideShowDescriptions.append(pressurePlateDoubleDoorDescriptionSS)
        listOfSlideShowDescriptions.append(flushPistonDoorDescriptionSS)
        listOfSlideShowDescriptions.append(flushBasement)
        listOfSlideShowDescriptions.append(piston3x3)
        listOfSlideShowDescriptions.append(ceiling)
        
        listOfSlideShowImageNames.append(button2x2PistonDoorImageSS)
        listOfSlideShowImageNames.append(pressurePlate2x2PistonDoorImageSS)
        listOfSlideShowImageNames.append(pressurePlateDoubleDoorImageSS)
        listOfSlideShowImageNames.append(flushPistonDoorImageSS)
        listOfSlideShowImageNames.append(flushBasementImages)
        listOfSlideShowImageNames.append(piston3x3Images)
        listOfSlideShowImageNames.append(ceilingImages)
        
        
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

extension DoorsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listEntryLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "listCellDoors") as! ListCellDoors
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
            alert = UIAlertController(title: "Upgrade to Full Version?", message: "Upgrade to the Full Version to remove ads and unlock all content.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No thanks", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Upgrade", style: .default, handler: { action in
                self.upgradeClicked()
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        let newScreen = self.storyboard?.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
        newScreen.slideShowName = listEntryLabels[indexPath.row]
        newScreen.listOfDescriptions = listOfSlideShowDescriptions[indexPath.row]
        newScreen.listOfImageNames = listOfSlideShowImageNames[indexPath.row]
        newScreen.senderVCIdentifier = "unwindToDoorsVC"
        
        newScreen.modalPresentationStyle = .fullScreen
        self.present(newScreen, animated: true, completion: nil)
        
    }
}

extension DoorsViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(animationDuration: global.ANIMATION_DURATION, animationType: .present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(animationDuration: global.ANIMATION_DURATION, animationType: .dismiss)
    }
}
