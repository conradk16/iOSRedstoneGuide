//
//  FarmsViewController.swift
//  Minecraft Redstone Guide
//
//  Created by Stefan Kuklinsky on 5/8/20.
//  Copyright © 2020 Stefan Kuklinsky. All rights reserved.
//

import UIKit

class FarmsViewController: UIViewController {

    @IBOutlet weak var backImgView: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    
    var listEntryLabels:[String] = []
    var listEntryImages:[UIImage] = []
    
    var listOfSlideShowDescriptions:[[String]] = []
    var listOfSlideShowImageNames:[[String]] = []
    
    var locked:[Bool] = [false, false, false, true]
    var difficulties:[Int] = [2, 2, 3, 4]
    
    @IBAction func unwindToFarmsVC(segue: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.transitioningDelegate = self
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
                
        listEntryLabels.append("Cow Farm")
        listEntryLabels.append("Chicken Farm")
        listEntryLabels.append("Crop Harvester")
        listEntryLabels.append("Sugar Farm")
        listEntryImages.append(UIImage(named: "cow_farm_cover_img")!)
        listEntryImages.append(UIImage(named: "chicken_farm_cover_img")!)
        listEntryImages.append(UIImage(named: "crop_harvester_cover_img")!)
        listEntryImages.append(UIImage(named: "sugar_farm_cover_img")!)
        
        let cowD:[String] = ["Place a chest and six hoppers as shown. To place a hopper facing into a container without opening it, crouch while placing it.", "Place blocks and redstone components. Set all redstone repeaters to 1 tick.", "Place sticky pistons and blocks.", "Place blocks and fences. Bring two or more cows into the enclosure.", "Breed the cows with wheat until you have many cows. Each cow will need to wait 5 minutes before it can breed again.", "Breed all cows one last time.", "Flick the switch to suffocate all of the adult cows. Leather and beef will collect in the chest.", "The babies will survive. Wait for these to grow up and then repeat the process."]
        let cowI:[String] = ["cow_farm_img_1", "cow_farm_img_2", "cow_farm_img_3", "cow_farm_img_4", "cow_farm_img_5", "cow_farm_img_6", "cow_farm_img_7", "cow_farm_img_8"]
        
        let chickenD:[String] = ["Place a chest and two hoppers as shown. To place a hopper facing into another container without opening it, crouch while placing it.", "Place blocks and redstone components.", "Place a sticky piston, a dispenser, a hopper, and a piece of redstone dust. Crouch while placing the hopper to avoid opening the dispenser.", "", "", "", "Throw eggs into the top of the farm to hatch chickens. You can also breed these chickens together to make your farm produce faster.", "Chickens will appear behind the glass over time. Once there are enough fully grown chickens, flick the lever to suffocate them and the meat and feathers will collect in the chest."]
        let chickenI:[String] = ["chicken_farm_img_1", "chicken_farm_img_2", "chicken_farm_img_3", "chicken_farm_img_4", "chicken_farm_img_5", "chicken_farm_img_6", "chicken_farm_img_7", "chicken_farm_img_8"]

        let sugarD:[String] = ["Place a chest and two hoppers as shown. To place a hopper facing into another container without opening it, crouch while placing it.", "Place blocks, dirt, and sticky pistons.", "", "Place blocks.", "Place redstone components. All redstone repeaters should be set to 1 tick.", "Build a 5x5 platform and place blocks and redstone components.", "Place more blocks, a comparator, and regular pistons.", "Place two hoppers facing into each other. To do this, first place one hopper. Then, while crouching, place the other hopper facing into the first. Then destroy the first hopper and place it again, this time facing into the second hopper (Place this while crouching, too).", "Place blocks and redstone components.", "Fill the right hopper with 5 stacks of items (any items).", "As soon as you start to place the items, they will start getting pushed into the other hopper. Make sure to not place more than 5 full stacks (fewer is okay).", "Place 3 pieces of redstone dust.", "Place blocks to keep the sugar inside the farm.", "Place 2 water blocks to create a stream of water that flows into the hoppers. Place sugar cane on the dirt.", "Place blocks to cover the other side. Now just wait and sugar will gather in the chest."]
        let sugarI:[String] = ["sugar_farm_img_1", "sugar_farm_img_2", "sugar_farm_img_3", "sugar_farm_img_4", "sugar_farm_img_5", "sugar_farm_img_6", "sugar_farm_img_7", "sugar_farm_img_8", "sugar_farm_img_9", "sugar_farm_img_10", "sugar_farm_img_11", "sugar_farm_img_12", "sugar_farm_img_13", "sugar_farm_img_14", "sugar_farm_img_15"]
        
        let cropD:[String] = ["Place a chest and two hoppers as shown. To place a hopper facing into another container without opening it, crouch while placing it.", "Place blocks and dirt.", "", "Place 3 water blocks. The bottom water will carry the items to the hoppers. The water on the sides will keep the crops irrigated.", "Place blocks and redstone components. Set the bottom 3 redstone repeaters to 4 ticks. Set the other redstone repeaters to 1 tick.", "Place blocks on top of the side waterways and place dispensers.", "Place a bucket of water into each dispenser.", "Add more blocks.", "Ho the dirt.", "Place seeds. You can farm wheat, carrots, potatoes, or beetroots.", "Once crops are fully grown, press the button to harvest the crops. They will collect in the chest."]
        let cropI:[String] = ["crop_harvester_img_1", "crop_harvester_img_2", "crop_harvester_img_3", "crop_harvester_img_4", "crop_harvester_img_5", "crop_harvester_img_6", "crop_harvester_img_7", "crop_harvester_img_8", "crop_harvester_img_9", "crop_harvester_img_10", "crop_harvester_img_11"]
        
        listOfSlideShowDescriptions.append(cowD)
        listOfSlideShowDescriptions.append(chickenD)
        listOfSlideShowDescriptions.append(cropD)
        listOfSlideShowDescriptions.append(sugarD)
        
        listOfSlideShowImageNames.append(cowI)
        listOfSlideShowImageNames.append(chickenI)
        listOfSlideShowImageNames.append(cropI)
        listOfSlideShowImageNames.append(sugarI)
        
        

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

extension FarmsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listEntryLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "listCellFarms") as! ListCellFarms
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
        newScreen.senderVCIdentifier = "unwindToFarmsVC"
        
        newScreen.modalPresentationStyle = .fullScreen
        self.present(newScreen, animated: true, completion: nil)
        
    }
}

extension FarmsViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(animationDuration: global.ANIMATION_DURATION, animationType: .present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(animationDuration: global.ANIMATION_DURATION, animationType: .dismiss)
    }
}

