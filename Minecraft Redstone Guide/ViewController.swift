//
//  ViewController.swift
//  Minecraft Redstone Guide
//
//  Created by Stefan Kuklinsky on 3/31/20.
//  Copyright © 2020 Stefan Kuklinsky. All rights reserved.
//


import UIKit
import PersonalizedAdConsent

class ViewController: UIViewController {
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var settingsImgView: UIImageView!
    
    var listEntryLabels:[String] = []
    var listEntryImages:[UIImage] = []
    let correspondingVCIDs:[String] = ["DoorsViewController", "TrapsViewController", "FarmsViewController", "ItemsViewController", "BasicCircuitsAndContraptionsViewController", "WiringViewController"]
    
    @IBAction func unwindToHomeVC(segue: UIStoryboardSegue) {
        if (global.fullVersion) {
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (!global.previouslyLoadedMainVC) {
            global.previouslyLoadedMainVC = true
            let newScreen = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            newScreen.modalPresentationStyle = .fullScreen
            self.present(newScreen, animated: false, completion: nil)
        }
        if (global.fullVersion) {
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.transitioningDelegate = self
        
        listEntryLabels.append("Doors")
        listEntryLabels.append("Traps")
        listEntryLabels.append("Farms")
        listEntryLabels.append("Items")
        listEntryLabels.append("Basic Circuits and Contraptions")
        listEntryLabels.append("Wiring")
        listEntryImages.append(UIImage(named: "pressure_plate_2x2_piston_door_cover_img")!)
        listEntryImages.append(UIImage(named: "lava_trap_cover_img")!)
        listEntryImages.append(UIImage(named: "cow_farm_cover_img")!) // FARMS COVER IMAGE
        listEntryImages.append(UIImage(named: "redstone_repeater_cover_img")!)
        listEntryImages.append(UIImage(named: "circuit_breaker_cover_img")!)
        listEntryImages.append(UIImage(named: "downward_signal_cover_img")!)
        
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.separatorStyle = .none
        self.view.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 255/255)
        mainLabel.backgroundColor = UIColor.init(red: 226/255, green: 56/255, blue: 56/255, alpha: 255/255)
        listTableView.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 255/255)
        
        settingsImgView.image = UIImage(named: "settings")
        let singleTapSettings = UITapGestureRecognizer(target: self, action: #selector(settingsBtnTapDetected))
        settingsImgView.isUserInteractionEnabled = true
        settingsImgView.addGestureRecognizer(singleTapSettings)
        
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor.init(red: 226/255, green: 56/255, blue: 56/255, alpha: 255/255)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
        
        
        if (global.previouslyLoadedMainVC) {
            if let purchased = global.loadIAP() {
                global.fullVersion = purchased
            }
            
            global.fullVersion = true
            
            
            if (global.actionCountForReview == 0) { // just installed
                UserDefaults.standard.set(true, forKey: "paidForApp")
                global.paidForApp = UserDefaults.standard.bool(forKey: "paidForApp")
            }
            
            if (global.paidForApp) {
                global.fullVersion = true
            }
 
            
            
            if (!global.fullVersion) {
                let inEEA:Bool = PACConsentInformation.sharedInstance.isRequestLocationInEEAOrUnknown
                if inEEA {
                    if (global.personalizedAds == 0) { // default status
                        getConsent()
                    }
                } else {
                    UserDefaults.standard.set(5, forKey: "personalizedAds") // 5 means not in EEAorUnknown - can show personalized ads
                }
                global.loadNewInterstitialAd()
            }
        
            global.timeOpenedOrLastAdShown =  Int(Date().timeIntervalSinceReferenceDate) - 30
            print(global.timeOpenedOrLastAdShown)
        }
        
        if (!global.previouslyLoadedMainVC) {
            listTableView.allowsSelection = false
            settingsImgView.isUserInteractionEnabled = false
        }
            
    }
    
    //Action
    @objc func settingsBtnTapDetected() {
        let newScreen = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        newScreen.modalPresentationStyle = .fullScreen
        self.present(newScreen, animated: true, completion: nil)
    }
    
    func getConsent() {
        let alert = UIAlertController(title: "Can we use your data to show you more relevant ads?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes, see relevant ads", style: .default, handler: { action in self.consentedToPersonalizedAds() }))
        alert.addAction(UIAlertAction(title: "No, see ads that are less relevant", style: .default, handler: { action in
            self.consentedToUnpersonalizedAds()
        }))
        alert.addAction(UIAlertAction(title: "Upgrade to the ad-free version", style: .default, handler: { action in self.upgradeClicked() }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func consentedToPersonalizedAds() {
        UserDefaults.standard.set(1, forKey: "personalizedAds") // personalized ads allowed
    }
    
    func consentedToUnpersonalizedAds() {
        UserDefaults.standard.set(2, forKey: "personalizedAds") // personalized ads not allowed
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listEntryLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "listCellMain") as! ListCellMain

        if (global.width == 0) {
            DispatchQueue.main.async {
                //access to the frame/bounds
                global.width = cell.self.imgImageView.bounds.size.width
            }
        }
        
        cell.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 255/255)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.setCell(img: self.listEntryImages[indexPath.row], label: self.listEntryLabels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        switch indexPath.row {
        case 0:
            let newScreen = self.storyboard?.instantiateViewController(withIdentifier: correspondingVCIDs[indexPath.row]) as! DoorsViewController
            newScreen.modalPresentationStyle = .fullScreen
            self.present(newScreen, animated: true, completion: nil)
        case 1:
            let newScreen = self.storyboard?.instantiateViewController(withIdentifier: correspondingVCIDs[indexPath.row]) as! TrapsViewController
            newScreen.modalPresentationStyle = .fullScreen
            self.present(newScreen, animated: true, completion: nil)
        case 2:
            let newScreen = self.storyboard?.instantiateViewController(withIdentifier: correspondingVCIDs[indexPath.row]) as! FarmsViewController
            newScreen.modalPresentationStyle = .fullScreen
            self.present(newScreen, animated: true, completion: nil)
        case 3:
            let newScreen = self.storyboard?.instantiateViewController(withIdentifier: correspondingVCIDs[indexPath.row]) as! ItemsViewController
            newScreen.modalPresentationStyle = .fullScreen
            self.present(newScreen, animated: true, completion: nil)
        case 4:
            let newScreen = self.storyboard?.instantiateViewController(withIdentifier: correspondingVCIDs[indexPath.row]) as! BasicCircuitsAndContraptionsViewController
            newScreen.modalPresentationStyle = .fullScreen
            self.present(newScreen, animated: true, completion: nil)
        case 5:
            let newScreen = self.storyboard?.instantiateViewController(withIdentifier: correspondingVCIDs[indexPath.row]) as! WiringViewController
            newScreen.modalPresentationStyle = .fullScreen
            self.present(newScreen, animated: true, completion: nil)
        default:
            return
        }
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(animationDuration: global.ANIMATION_DURATION, animationType: .present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(animationDuration: global.ANIMATION_DURATION, animationType: .dismiss)
    }
}
