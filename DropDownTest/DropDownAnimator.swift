//
//  DropDownAnimator.swift
//  Sake-st
//
//  Created by Toshi Fujita on 2018/05/11.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import UIKit

class DropDownAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    enum Direction {
        case present
        case dismiss
    }
    
    let direction :Direction
    
    init(direction: Direction) {
        self.direction = direction
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch direction {
        case .present:
            present(using: transitionContext)
        case .dismiss:
            dismiss(using: transitionContext)
        }
    }
    
    func present(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) else {
            return
        }
        
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        toViewController.view.frame = finalFrame
        let containerView = transitionContext.containerView
        containerView.addSubview(toViewController.view)
        
        toViewController.view.frame.size.height = 0
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .curveEaseInOut, animations: {
            toViewController.view.frame.size.height = finalFrame.height
            }, completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
        
    }
    
    func dismiss(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) else {
            return
        }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .curveEaseInOut, animations: {
            fromViewController.view.frame.size.height = 0
            }, completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
        
    }
    
}
