//
//  FlipPresentAnimationController.swift
//  The Hitchhiker Prophecy
//
//  Created by Ahmed Nasser on 21/03/2021.
//  Copyright © 2021 SWVL. All rights reserved.
//

import UIKit

class FlipPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let originFrame: CGRect
    
    init(originFrame: CGRect) {
        self.originFrame = originFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to),
              let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false)
        else {
            return
        }
        
        snapshot.layer.cornerRadius = 8
        snapshot.layer.masksToBounds = true
        
        let containerView = transitionContext.containerView
        containerView.insertSubview(toVC.view, at: 0)
        containerView.addSubview(snapshot)
        fromVC.view.isHidden = true
        
        AnimationHelper.perspectiveTransform(for: containerView)
        toVC.view.layer.transform = AnimationHelper.yRotation(.pi / 2)
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/2) {
                    snapshot.layer.transform = AnimationHelper.yRotation(-.pi / 2)
                }
                
                UIView.addKeyframe(withRelativeStartTime: 1/2, relativeDuration: 1/2) {
                    toVC.view.layer.transform = AnimationHelper.yRotation(0.0)
                }
            },
            completion: { _ in
                fromVC.view.isHidden = false
                snapshot.removeFromSuperview()
                if transitionContext.transitionWasCancelled {
                    toVC.view.removeFromSuperview()
                }
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
    }
}

