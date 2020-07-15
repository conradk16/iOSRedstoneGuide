//
//  SettingsViewController.swift
//  Minecraft Redstone Guide
//
//  Created by Stefan Kuklinsky on 4/2/20.
//  Copyright © 2020 Stefan Kuklinsky. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var settingsBackBtn: UIImageView!
    @IBOutlet weak var rateBtn: Button!
    @IBOutlet weak var upgradeBtn: Button!
    @IBOutlet weak var restoreBtn: Button!
    
    @IBAction func rateClicked(_ sender: Any) {
        if let url = URL(string: "http://itunes.apple.com/app/id1506067815?action=write-review") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    @IBAction func upgradeClicked(_ sender: Any) {
        var alert:UIAlertController
        alert = UIAlertController(title: "Upgrade to Full Version?", message: "Upgrade to the Full Version to remove ads and unlock all content.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No thanks", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Upgrade", style: .default, handler: { action in
            self.upgradeClicked()
        }))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func restoreClicked(_ sender: Any) {
        global.groupRestore.enter()
        StoreObserver.shared.restore()
        global.groupRestore.notify(queue: .main) {
            if global.fullVersion {
                self.upgradeBtn.isEnabled = false
                self.restoreBtn.isEnabled = false
                let alert = UIAlertController(title: "Purchase restored", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                if global.didConnectToItunes {
                    let alert = UIAlertController(title: "No purchases to restore", message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Could not connect to iTunes", message: "Please try again later", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    global.didConnectToItunes = true // reset var
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.transitioningDelegate = self
        
        settingsLabel.backgroundColor = UIColor.init(red: 226/255, green: 56/255, blue: 56/255, alpha: 255/255)
        
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor.init(red: 226/255, green: 56/255, blue: 56/255, alpha: 255/255)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
        
        settingsBackBtn.image = UIImage(named: "back")
        let singleTapBack = UITapGestureRecognizer(target: self, action: #selector(backBtnTapDetected))
        settingsBackBtn.isUserInteractionEnabled = true
        settingsBackBtn.addGestureRecognizer(singleTapBack)
        
        if (global.fullVersion) {
            upgradeBtn.isEnabled = false
            restoreBtn.isEnabled = false
        }
    }
    
    @objc func backBtnTapDetected() {
        self.dismiss(animated: true, completion: nil)
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
                    if global.fullVersion {
                        self.upgradeBtn.isEnabled = false
                        self.restoreBtn.isEnabled = false
                    } else if global.couldNotConnectToItunesPurchasing {
                        let alert = UIAlertController(title: "Could not connect to iTunes store", message: "Please try again later", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        global.couldNotConnectToItunesPurchasing = false
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

extension SettingsViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(animationDuration: global.ANIMATION_DURATION, animationType: .present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(animationDuration: global.ANIMATION_DURATION, animationType: .dismiss)
    }
}

