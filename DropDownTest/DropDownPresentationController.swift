//
//  SortPulldown.swift
//  Sake-st
//
//  Created by Toshi Fujita on 2018/05/11.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import UIKit

class
DropDownPresentationController: UIPresentationController {
    
    // Set the size of dropdown box
    let dropDownSize = CGSize(width: 200, height: 120)
    
    private lazy var overlayView: UIView = {
        let overlayView = UIView()
        // Sets the darkness of background when the modal is being shown
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0)
        let rec = UITapGestureRecognizer(target: self, action: #selector(DropDownPresentationController.overlayViewDidTap(sender:)))
        overlayView.addGestureRecognizer(rec)
        return overlayView
    }()
    
    private let maskLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.black.withAlphaComponent(0.5).cgColor
        layer.fillRule = kCAFillRuleEvenOdd
        return layer
    }()
    
    var targetFrame = CGRect.zero
    
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        maskLayer.frame = overlayView.bounds
        
        // Set the overlayView as the frame of parent's containerView i.e. the frame of iPhone device being used
        overlayView.frame = containerView?.frame ?? .zero
        containerView?.insertSubview(overlayView, at: 0)
        
        maskLayer.path = {
            let maskPath = UIBezierPath(rect: overlayView.bounds)
            maskPath.append(UIBezierPath(rect: targetFrame))
            return maskPath.cgPath
        }()
        overlayView.layer.mask = maskLayer
        
        overlayView.alpha = 0
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] context in
            self?.overlayView.alpha = 0.5
            }, completion: {(_) in })
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: {
            [weak self] context in
            self?.overlayView.alpha = 0.0
            }, completion: { [weak self] context in
                self?.overlayView.removeFromSuperview()
        })
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
    }

    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        // return the size of the modal window
        return dropDownSize
        //return CGSize(width: targetFrame.width, height: 200)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        
        let containerSize = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView?.bounds.size ?? .zero)
        print("DEBUG: CGRect->\(CGRect(origin: CGPoint(x: targetFrame.maxX - dropDownSize.width, y: targetFrame.maxY), size: containerSize))")
        return CGRect(origin: CGPoint(x: targetFrame.maxX - dropDownSize.width, y: targetFrame.maxY ), size: containerSize)
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        self.overlayView.frame = containerView?.frame ?? .zero
    }
    
    @objc func overlayViewDidTap(sender: UITapGestureRecognizer) {
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
}
