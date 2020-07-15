//
//  InfoViewController.swift
//  Minecraft Redstone Guide
//
//  Created by Stefan Kuklinsky on 4/1/20.
//  Copyright © 2020 Stefan Kuklinsky. All rights reserved.
//

import UIKit
import StoreKit
import GoogleMobileAds
import PersonalizedAdConsent

class InfoViewController: UIViewController {

    var slideShowName:String = ""
    var slideShowNumber:Int = 0
    var listOfDescriptions:[String] = []
    var listOfImageNames:[String] = []
    var senderVCIdentifier = ""
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var nextBtnOutlet: Button!
    @IBOutlet weak var backBtnOutlet: Button!
    @IBOutlet weak var backImgView: UIImageView!
    @IBOutlet weak var homeImgView: UIImageView!
    @IBOutlet weak var slideNumberLabel: UILabel!
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var bannerViewHeight: NSLayoutConstraint!
    
    @IBAction func nextBtnClicked(_ sender: Any) {
        newSlide(newSlideNumber: slideShowNumber + 1)
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        newSlide(newSlideNumber: slideShowNumber - 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.transitioningDelegate = self
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)

        imgImageView.contentMode = .scaleAspectFill
        imgImageView.layer.cornerRadius = 14.0
        imgImageView.layer.masksToBounds = true
        
        titleLabel.backgroundColor = UIColor.init(red: 226/255, green: 56/255, blue: 56/255, alpha: 255/255)
        
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor.init(red: 226/255, green: 56/255, blue: 56/255, alpha: 255/255)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
        
        titleLabel.text = slideShowName
        textLabel.text = listOfDescriptions[slideShowNumber]
        if (listOfDescriptions[slideShowNumber].count > 0) {
            textLabel.backgroundColor = UIColor.init(red: 39/255, green: 135/255, blue: 235/255, alpha: 255/255)
        } else {
            textLabel.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 255/255)
        }
        imgImageView.image = UIImage(named: listOfImageNames[slideShowNumber])
        
        if (slideShowNumber == 0) {
            backBtnOutlet.isHidden = true
        }
        if (slideShowNumber == (listOfDescriptions.count - 1)) {
            nextBtnOutlet.isHidden = true
        }
        
        slideNumberLabel.text = String(slideShowNumber + 1) + "/" + String(listOfDescriptions.count)
        slideNumberLabel.textColor = UIColor.init(red: 195/255, green: 195/255, blue: 195/255, alpha: 255/255)
        
        backImgView.image = UIImage(named: "back")
        let singleTapBack = UITapGestureRecognizer(target: self, action: #selector(backBtnTapDetected))
        backImgView.isUserInteractionEnabled = true
        backImgView.addGestureRecognizer(singleTapBack)
        
        homeImgView.image = UIImage(named: "home")
        let singleTapHome = UITapGestureRecognizer(target: self, action: #selector(homeBtnTapDetected))
        homeImgView.isUserInteractionEnabled = true
        homeImgView.addGestureRecognizer(singleTapHome)
        
        
        if (!global.fullVersion) {
            //bannerView.adUnitID = "ca-app-pub-6860445609360439/9134438891" // REAL AD ID
            bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716" // TEST AD ID
            bannerView.rootViewController = self
            bannerView.delegate = self
            
            let inEEA:Bool = PACConsentInformation.sharedInstance.isRequestLocationInEEAOrUnknown
            if inEEA {
                if (global.personalizedAds == 0) { // default status
                    getConsent()
                }
            } else {
                UserDefaults.standard.set(5, forKey: "personalizedAds") // 5 means not in EEAorUnknown - can show personalized ads
            }
            
            if (global.personalizedAds != 1 && global.personalizedAds != 5) { // if in EEA and did not consent to personalized ads
                let request = GADRequest()
                let extras = GADExtras()
                extras.additionalParameters = ["npa": "1"]
                request.register(extras)
                bannerView.load(request)
            } else {
                bannerView.load(GADRequest()) //personalized
            }
        } else {
            bannerView.isHidden = true
            bannerViewHeight.constant = 0
        }

    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                if (slideShowNumber != 0) {
                    newSlide(newSlideNumber: slideShowNumber - 1)
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            case UISwipeGestureRecognizer.Direction.down:
                print("Swiped down")
            case UISwipeGestureRecognizer.Direction.left:
                if (slideShowNumber != (listOfDescriptions.count - 1)) {
                    newSlide(newSlideNumber: slideShowNumber + 1)
                }
            case UISwipeGestureRecognizer.Direction.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
    @objc func backBtnTapDetected() {
        if (slideShowNumber == 0) {
            self.dismiss(animated: true, completion: nil)
        } else {
            let anim_duration = global.ANIMATION_DURATION
            global.ANIMATION_DURATION = 0.0
            self.performSegue(withIdentifier: senderVCIdentifier, sender: self)
            global.ANIMATION_DURATION = anim_duration
        }
    }
    @objc func homeBtnTapDetected() {
        
        let anim_duration = global.ANIMATION_DURATION
        global.ANIMATION_DURATION = 0.0
        self.performSegue(withIdentifier: "unwindToHomeVC", sender: self)
        global.ANIMATION_DURATION = anim_duration
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
                        if (self.bannerView != nil) {
                            self.bannerView.isHidden = true
                            self.bannerViewHeight.constant = 0
                        }
                    }
                }
            } else { //could not fetch
                let alert = UIAlertController(title: "Could not connect to iTunes store", message: "Please try again later", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func newSlide(newSlideNumber:Int) {
        slideShowNumber = newSlideNumber
        let newImage:UIImage = UIImage(named: listOfImageNames[slideShowNumber])!
        let newText:String = listOfDescriptions[slideShowNumber]
        
        UIView.transition(with: imgImageView,
        duration: 0.75,
        options: .transitionCrossDissolve,
        animations: { self.imgImageView.image = newImage },
        completion: nil)
    
        UIView.transition(with: textLabel,
        duration: 0.75,
        options: .transitionCrossDissolve,
        animations: { self.textLabel.text = newText },
        completion: nil)
        
        if (slideShowNumber == 0) {
            backBtnOutlet.isHidden = true
            nextBtnOutlet.isHidden = false
        } else if (slideShowNumber == (listOfDescriptions.count - 1)) {
            nextBtnOutlet.isHidden = true
            backBtnOutlet.isHidden = false
        } else {
            backBtnOutlet.isHidden = false
            nextBtnOutlet.isHidden = false
        }
        
        slideNumberLabel.text = String(slideShowNumber + 1) + "/" + String(listOfDescriptions.count)
        if (newText.count > 0) {
            textLabel.backgroundColor = UIColor.init(red: 39/255, green: 135/255, blue: 235/255, alpha: 255/255)
        } else {
            textLabel.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 255/255)
        }
        
        global.addToActionCountForReview(numToBeAdded: 1)
        
        if (global.timeToAskForReview() && global.isConnectedToInternet()) {
            let halfSecondFromNow = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: halfSecondFromNow) {
                SKStoreReviewController.requestReview()
                global.updateCurrentThreshold()
            }
        } else if (global.shouldShowInterstitial()) {
            global.showAdAndReloadInterstitial(rootViewController: self)
        }
    }

}

extension InfoViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(animationDuration: global.ANIMATION_DURATION, animationType: .present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(animationDuration: global.ANIMATION_DURATION, animationType: .dismiss)
    }
}

extension InfoViewController: GADBannerViewDelegate {
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("ad received")
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print(error)
    }
}
