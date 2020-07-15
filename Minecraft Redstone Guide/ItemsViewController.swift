//
//  ItemsViewController.swift
//  Minecraft Redstone Guide
//
//  Created by Stefan Kuklinsky on 3/31/20.
//  Copyright © 2020 Stefan Kuklinsky. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController {
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var backImgView: UIImageView!
    
    var listEntryLabels:[String] = []
    var listEntryImages:[UIImage] = []
    
    var listOfSlideShowDescriptions:[[String]] = []
    var listOfSlideShowImageNames:[[String]] = []
    
    var locked:[Bool] = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    
    @IBAction func unwindToItemsVC(segue: UIStoryboardSegue) {
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.transitioningDelegate = self
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        listEntryLabels.append("Redstone Dust")
        listEntryLabels.append("Redstone Torch")
        listEntryLabels.append("Lever")
        listEntryLabels.append("Button")
        listEntryLabels.append("Pressure Plate")
        listEntryLabels.append("Redstone Block")
        listEntryLabels.append("Redstone Repeater")
        listEntryLabels.append("Comparator")
        listEntryLabels.append("Dispenser")
        listEntryLabels.append("Dropper")
        listEntryLabels.append("Piston")
        listEntryLabels.append("Observer")
        listEntryLabels.append("Hopper")
        listEntryLabels.append("Trapped Chest")
        listEntryLabels.append("Misc Redstone Items")
        listEntryImages.append(UIImage(named: "redstone_dust_cover_img")!)
        listEntryImages.append(UIImage(named: "redstone_torch_cover_img")!)
        listEntryImages.append(UIImage(named: "lever_cover_img")!)
        listEntryImages.append(UIImage(named: "button_cover_img")!)
        listEntryImages.append(UIImage(named: "pressure_plate_cover_img")!)
        listEntryImages.append(UIImage(named: "redstone_block_cover_img")!)
        listEntryImages.append(UIImage(named: "redstone_repeater_cover_img")!)
        listEntryImages.append(UIImage(named: "comparator_cover_img")!)
        listEntryImages.append(UIImage(named: "dispenser_cover_img")!)
        listEntryImages.append(UIImage(named: "dropper_cover_img")!)
        listEntryImages.append(UIImage(named: "piston_cover_img")!)
        listEntryImages.append(UIImage(named: "observer_cover_img")!)
        listEntryImages.append(UIImage(named: "hopper_cover_img")!)
        listEntryImages.append(UIImage(named: "trapped_chest_cover_img")!)
        listEntryImages.append(UIImage(named: "miscellaneous_redstone_items_cover_img")!)
        
        let redstoneDustDescriptionSS:[String] = ["You can obtain redstone dust by mining redstone ore.", "Redstone dust can only be placed on top of blocks. It has a low hitbox.", "Neighboring redstone dust connects to form a wire which can transmit signals from a power source (for example a redstone torch) up to 15 blocks away. In this example, the right lamp is off because it is too far away from the power source.", "Signals moving up or down will be stopped by solid blocks.", "On Java Edition, redstone dust only powers blocks in the direction the signal is moving, and blocks underneath it. On Bedrock Edition (console and mobile), redstone also configures itself to power blocks to the side.", "In the special cases where a single piece of redstone dust rests on a \"highly powered\" block (see lever and redstone torch), the redstone dust looks like a dot and provides power to blocks on all sides. This is mostly useful on Java Edition, where redstone dust doesn't automatically power blocks on its sides."]
        listOfSlideShowDescriptions.append(redstoneDustDescriptionSS)
        let redstoneDustImageSS:[String] = ["redstone_dust_img_1", "redstone_dust_img_2", "redstone_dust_img_3", "redstone_dust_img_4", "redstone_dust_img_5", "redstone_dust_img_6"]
        listOfSlideShowImageNames.append(redstoneDustImageSS)
        
        let redstoneTorchDescriptionSS:[String] = ["How to craft it.", "Redstone torches can be placed on top of blocks or attached to the sides.", "A redstone torch generates a redstone signal on all four sides.", "A redstone torch can generate a redstone signal downward if attached to the side of a block.", "A redstone torch \"highly powers\" the block above it, meaning this block can generate redstone signals on its sides and above it.", "A redstone torch can be extinguished if the block it is attached to receives power from another source."]
        listOfSlideShowDescriptions.append(redstoneTorchDescriptionSS)
        let redstoneTorchImageSS:[String] = ["redstone_torch_img_1", "redstone_torch_img_2", "redstone_torch_img_3", "redstone_torch_img_4", "redstone_torch_img_5", "redstone_torch_img_6"]
        listOfSlideShowImageNames.append(redstoneTorchImageSS)
        
        let leverDescriptionSS:[String] = ["How to craft it.", "Levers can be placed on the sides, on top of, or underneath blocks.", "When activated, a lever produces a redstone signal on all sides and above it. When deactivated, it produces no power.", "When active, a lever \"highly powers\" the block it is attached to, meaning this block can generate a redstone signal on all sides, including above and below it."]
        listOfSlideShowDescriptions.append(leverDescriptionSS)
        let leverImageSS:[String] = ["lever_img_1", "lever_img_2", "lever_img_3", "lever_img_4"]
        listOfSlideShowImageNames.append(leverImageSS)

        let buttonDescriptionSS:[String] = ["How to craft it.", "Buttons can be placed on the sides, on top of, or underneath blocks.", "When pressed, a button produces a redstone signal on all sides, including above and below it. Buttons automatically deactivate after a short amount of time (1.5 seconds for wooden buttons, and 1 second for stone buttons).", "Wooden buttons can also be activated with an arrow, and will stay activated as long as the arrow is not collected.", "Just like a lever, an activated button \"highly powers\" the block it is attached to, meaning this block can generate redstone signals on all sides, including above and below it."]
        listOfSlideShowDescriptions.append(buttonDescriptionSS)
        let buttonImageSS:[String] = ["button_img_1", "button_img_2", "button_img_3", "button_img_4", "button_img_5"]
        listOfSlideShowImageNames.append(buttonImageSS)
        
        let pressurePlateDescriptionSS:[String] = ["How to craft it.", "Pressure plates can be placed on top of blocks. They are activated when players step on them. Wooden pressure plates can also be activated with dropped items.", "When activated, a pressure plate produces a redstone signal on all sides and above it.", "Just like a lever, an activated pressure plate \"highly powers\" the block it is attached to, meaning this block can produce a redstone signal on all sides, including above and below it."]
        listOfSlideShowDescriptions.append(pressurePlateDescriptionSS)
        let pressurePlateImageSS:[String] = ["pressure_plate_img_1", "pressure_plate_img_2", "pressure_plate_img_3", "pressure_plate_img_4"]
        listOfSlideShowImageNames.append(pressurePlateImageSS)
        
        let redstoneBlockDescriptionSS:[String] = ["How to craft it.", "A redstone block generates redstone signals on all sides, including above and below it."]
        listOfSlideShowDescriptions.append(redstoneBlockDescriptionSS)
        let redstoneBlockImageSS:[String] = ["redstone_block_img_1", "redstone_block_img_2"]
        listOfSlideShowImageNames.append(redstoneBlockImageSS)
        
        let redstoneRepeaterDescriptionSS:[String] = ["How to craft it.", "A redstone repeater can extend the range of a redstone signal. Without a repeater, signals only have a range of 15 blocks.", "A redstone repeater can also pick up a signal from any \"highly powered\" block (see lever and redstone torch) or any block receiving power from redstone dust.", "A redstone repeater can only be activated from behind.", "On Java Edition, redstone dust will turn to power a redstone repeater, unlike with other redstone components (See redstone dust, slide 5). On Bedrock Edition (console and mobile), redstone dust will always turn to power redstone components.", "An activated redstone repeater \"highly powers\" the block in front of it, meaning this block can produce a redstone signal on all sides, including above and below it.", "You can set the repeater delay to be 0.1, 0.2, 0.3, or 0.4 seconds. This is the time it takes to update the output signal after the input signal is changed. In this example, the nearest repeater is set to delay 1 (0.1 seconds), and the farthest repeater is set to delay 4 (0.4 seconds)."]
        listOfSlideShowDescriptions.append(redstoneRepeaterDescriptionSS)
        let redstoneRepeaterImageSS:[String] = ["redstone_repeater_img_1", "redstone_repeater_img_2", "redstone_repeater_img_3", "redstone_repeater_img_4", "redstone_repeater_img_5", "redstone_repeater_img_6", "redstone_repeater_img_7"]
        listOfSlideShowImageNames.append(redstoneRepeaterImageSS)
        
        let comparatorDescriptionSS:[String] = ["How to craft it.", "Comparators have two modes that you can toggle between. When the front torch is off, the comparator is in compare mode. When the front torch is on, the comparator is in subtract mode.", "A comparator takes three input signals: one from behind, one from the left, and one from the right. Each input signal has power from 0-15 depending on how close it is to a power source.", "When the comparator is in compare mode (front torch off), it checks whether or not the rear signal is the strongest input of the three input sources. If the rear signal is the strongest, or tied for the strongest, the comparator outputs the rear signal. Otherwise, no signal goes through.", "When in subtract mode (front torch on), the output is the rear input minus the larger of the two side inputs. In this example, the rear input is 14 (because it is 1 block away from a power source) and the largest side input is 12 (because it is 3 blocks away from a power source), so the output is 14 - 12 = 2, meaning the output signal has a range of 2 blocks.", "A comparator can also measure the fullness of a container placed behind it. The more items in the container, the stronger the output signal. In this example, the chest on the left contains the most items, so it outputs the strongest redstone signal."]
        listOfSlideShowDescriptions.append(comparatorDescriptionSS)
        let comparatorImageSS:[String] = ["comparator_img_1", "comparator_img_2", "comparator_img_3", "comparator_img_4", "comparator_img_5", "comparator_img_6"]
        listOfSlideShowImageNames.append(comparatorImageSS)
        
        let dispenserDescriptionSS:[String] = ["How to craft it.", "Dispensers are commonly used to shoot arrows. To use a dispenser, fill it with items (arrows or other dispensible items) and connect it to a redstone signal.", "When a dispenser is activated by a redstone signal, it dispenses an item. The redstone signal must be removed and then added again for the dispenser to dispense another item. To dispense multiple items in a row, use a clock.", "If a water or lava bucket is placed inside a dispenser, activating the dispenser will empty the bucket in front of the dispenser. Reactivating the dispenser will suck the water or lava back into the bucket.", "", ""]
        listOfSlideShowDescriptions.append(dispenserDescriptionSS)
        let dispenserImageSS:[String] = ["dispenser_img_1", "dispenser_img_2", "dispenser_img_3", "dispenser_img_4", "dispenser_img_5", "dispenser_img_6"]
        listOfSlideShowImageNames.append(dispenserImageSS)
        
        let dropperDescriptionSS:[String] = ["How to craft it.", "To use a dropper, load it with items and connect it to a redstone signal.", "When a dropper is activated by a redstone signal, it pops out an item. The redstone signal must be removed and then added again for the dropper to pop out another item. To pop out multiple items in a row, use a clock.", "If a dropper is facing another container (for example a chest), when activated it will push an item into that container."]
        listOfSlideShowDescriptions.append(dropperDescriptionSS)
        let dropperImageSS:[String] = ["dropper_img_1", "dropper_img_2", "dropper_img_3", "dropper_img_4"]
        listOfSlideShowImageNames.append(dropperImageSS)
        
        let pistonDescriptionSS:[String] = ["How to craft it.", "When connected to a redstone signal, a piston will extend, pushing whatever block is in front of it.", "When a regular piston is disconnected from a redstone signal, it contracts. When a sticky piston is disconnected from a redstone signal, it contracts and pulls back the block in front of it.", "", "Redstone blocks do not activate pistons directly facing them."]
        listOfSlideShowDescriptions.append(pistonDescriptionSS)
        let pistonImageSS:[String] = ["piston_img_1", "piston_img_2", "piston_img_3", "piston_img_4", "piston_img_5"]
        listOfSlideShowImageNames.append(pistonImageSS)
        
        let observerDescriptionSS:[String] = ["How to craft it.", "An observer outputs a very short redstone pulse if the block it is \"looking at\" changes. This could be used to detect crops growing, for example.", "In this example, placing the glass block sends a short pulse from the observer, briefly illuminating the lamp."]
        listOfSlideShowDescriptions.append(observerDescriptionSS)
        let observerImageSS:[String] = ["observer_img_1", "observer_img_2", "observer_img_3"]
        listOfSlideShowImageNames.append(observerImageSS)
        
        let hopperDescriptionSS:[String] = ["How to craft it.", "A hopper can be used to catch and transmit items. A hopper will suck in dropped items from above and push them forward if there is a container in front of it. In this example, an item dropped into any of the hoppers will get pushed into the chest.", "When activated by a redstone signal, a hopper is no longer able to suck in or push items."]
        listOfSlideShowDescriptions.append(hopperDescriptionSS)
        let hopperImageSS:[String] = ["hopper_img_1", "hopper_img_2", "hopper_img_3"]
        listOfSlideShowImageNames.append(hopperImageSS)
        
        let trappedChestDescriptionSS:[String] = ["When opened, a trapped chest will produce a weak redstone signal, which can be reamplified with a redstone repeater.", ""]
        listOfSlideShowDescriptions.append(trappedChestDescriptionSS)
        let trappedChestImageSS:[String] = ["trapped_chest_img_1", "trapped_chest_img_2"]
        listOfSlideShowImageNames.append(trappedChestImageSS)
        
        let miscellneousRedstoneItemsDescriptionSS:[String] = ["A wooden door can be activated by a redstone signal", "An iron door can be activated by a redstone signal", "A wooden trapdoor can be activated by a redstone signal", "An iron trapdoor can be activated by a redstone signal", "A fence gate can be activated by a redstone signal", "A note block can be activated by a redstone signal", "A redstone lamp can be activated by a redstone signal"]
        listOfSlideShowDescriptions.append(miscellneousRedstoneItemsDescriptionSS)
        let miscellneousRedstoneItemsImageSS:[String] = ["miscellaneous_redstone_items_img_1", "miscellaneous_redstone_items_img_2", "miscellaneous_redstone_items_img_3", "miscellaneous_redstone_items_img_4", "miscellaneous_redstone_items_img_5", "miscellaneous_redstone_items_img_6", "miscellaneous_redstone_items_img_7"]
        listOfSlideShowImageNames.append(miscellneousRedstoneItemsImageSS)
        
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

extension ItemsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listEntryLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "listCellItems") as! ListCellItems
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
        newScreen.senderVCIdentifier = "unwindToItemsVC"
        
        newScreen.transitioningDelegate = newScreen
        
        newScreen.modalPresentationStyle = .fullScreen
        self.present(newScreen, animated: true, completion: nil)
        
    }
}

extension ItemsViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(animationDuration: global.ANIMATION_DURATION, animationType: .present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(animationDuration: global.ANIMATION_DURATION, animationType: .dismiss)
    }
}
