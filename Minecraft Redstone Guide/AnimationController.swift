//
//  AnimationController.swift
//  Minecraft Redstone Guide
//
//  Created by Stefan Kuklinsky on 4/4/20.
//  Copyright © 2020 Stefan Kuklinsky. All rights reserved.
//

import Foundation
import UIKit

class AnimationController: NSObject {
    
    private let animationDuration: Double
    private let animationType: AnimationType
    
    enum AnimationType {
        case present
        case dismiss
    }
    
    init(animationDuration: Double, animationType: AnimationType) {
        self.animationType = animationType
        self.animationDuration = animationDuration
    }
    
}

extension AnimationController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(exactly: animationDuration) ?? 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to), let fromViewController = transitionContext.viewController(forKey: .from) else {
            transitionContext.completeTransition(false)
            return
        }
        
        switch animationType {
            case .present:
                transitionContext.containerView.addSubview(toViewController.view)
                //transitionContext.containerView.addSubview(fromViewController.view)
                presentAnimation(with: transitionContext, viewToAnimateTo: toViewController.view, viewToAnimateFrom: fromViewController.view)
            case .dismiss:
                transitionContext.containerView.addSubview(toViewController.view)
                //transitionContext.containerView.addSubview(fromViewController.view)
                dismissAnimation(with: transitionContext, viewToAnimateTo: toViewController.view, viewtoAnimateFrom: fromViewController.view)
            }
    }
    
    func presentAnimation(with transitionContext: UIViewControllerContextTransitioning, viewToAnimateTo: UIView, viewToAnimateFrom:UIView) {
        
        let duration = transitionDuration(using: transitionContext)
        
        viewToAnimateTo.clipsToBounds = true
        viewToAnimateTo.transform = CGAffineTransform(translationX: viewToAnimateTo.frame.width, y: 0)
        
        UIView.animate(withDuration: duration, animations: {
            viewToAnimateFrom.transform = CGAffineTransform(translationX: -viewToAnimateFrom.frame.width, y: 0)
            viewToAnimateTo.transform = CGAffineTransform(translationX: 0, y: 0)
        }) { _ in
            transitionContext.completeTransition(true)
        }
        
    }
    
    func dismissAnimation(with transitionContext: UIViewControllerContextTransitioning, viewToAnimateTo: UIView, viewtoAnimateFrom:UIView) {
        
        let duration = transitionDuration(using: transitionContext)
        
        viewToAnimateTo.clipsToBounds = true
        viewToAnimateTo.transform = CGAffineTransform(translationX: -viewToAnimateTo.frame.width, y: 0)
        
        UIView.animate(withDuration: duration, animations: {
            viewtoAnimateFrom.transform = CGAffineTransform(translationX: viewtoAnimateFrom.frame.width, y: 0)
            viewToAnimateTo.transform = CGAffineTransform(translationX: 0, y: 0)
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
}
