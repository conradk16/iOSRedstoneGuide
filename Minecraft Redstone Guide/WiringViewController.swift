//
//  WiringViewController.swift
//  Minecraft Redstone Guide
//
//  Created by Stefan Kuklinsky on 4/1/20.
//  Copyright © 2020 Stefan Kuklinsky. All rights reserved.
//

import UIKit

class WiringViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var backImgView: UIImageView!
    
    var listEntryLabels:[String] = []
    var listEntryImages:[UIImage] = []
    
    var listOfSlideShowDescriptions:[[String]] = []
    var listOfSlideShowImageNames:[[String]] = []
    
    var locked:[Bool] = [false, false, false]
    
    @IBAction func unwindToWiringVC(segue: UIStoryboardSegue) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.transitioningDelegate = self
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
                
        listEntryLabels.append("Upward Signal")
        listEntryLabels.append("Upward Signal with Slabs")
        listEntryLabels.append("Downward Signal")
        listEntryImages.append(UIImage(named: "upward_signal_cover_img")!)
        listEntryImages.append(UIImage(named: "upward_signal_with_slabs_cover_img")!)
        listEntryImages.append(UIImage(named: "downward_signal_cover_img")!)
        
        let upwardSignalDescriptionSS:[String] = ["Place items as shown. This structure can be built taller as needed.", ""]
        listOfSlideShowDescriptions.append(upwardSignalDescriptionSS)
        let upwardSignalImageSS:[String] = ["upward_signal_img_1", "upward_signal_img_2"]
        listOfSlideShowImageNames.append(upwardSignalImageSS)
        
        let upwardSignalWithSlabsDescriptionSS:[String] = ["Place temporary blocks in order to place slabs.", "Remove temporary blocks in order to place redstone."]
        listOfSlideShowDescriptions.append(upwardSignalWithSlabsDescriptionSS)
        let upwardSignalWithSlabsImageSS:[String] = ["upward_signal_with_slabs_img_1", "upward_signal_with_slabs_img_2"]
        listOfSlideShowImageNames.append(upwardSignalWithSlabsImageSS)
        
        let downwardSignalDescriptionSS:[String] = ["Place items as shown. This structure can be built taller as needed.", ""]
        listOfSlideShowDescriptions.append(downwardSignalDescriptionSS)
        let downwardSignalImageSS:[String] = ["downward_signal_img_1", "downward_signal_img_2"]
        listOfSlideShowImageNames.append(downwardSignalImageSS)

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

extension WiringViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listEntryLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "listCellWiring") as! ListCellWiring
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
        newScreen.senderVCIdentifier = "unwindToWiringVC"
        
        newScreen.modalPresentationStyle = .fullScreen
        self.present(newScreen, animated: true, completion: nil)
        
    }
}

extension WiringViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(animationDuration: global.ANIMATION_DURATION, animationType: .present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(animationDuration: global.ANIMATION_DURATION, animationType: .dismiss)
    }
}
