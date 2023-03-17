//
//  PresentationController.swift
//  testTask
//
//  Created by BigSynt on 11.03.2023.
//  Copyright © 2023 BigSynt. All rights reserved.
//

import UIKit

class PresentationController: UIPresentationController {
    
    var originY = CGFloat()
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        self.presentedView!.addGestureRecognizer(createSwipeGestureRecognizer(for: .up))
        self.presentedView!.addGestureRecognizer(createSwipeGestureRecognizer(for: .down))
    }
    
    private func createSwipeGestureRecognizer(for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeGestureRecognizer.direction = direction
        return swipeGestureRecognizer
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        CGRect(origin: CGPoint(x: 0, y: self.containerView!.frame.height * 0.5),
               size: CGSize(width: self.containerView!.frame.width, height: self.containerView!.frame.height))
    }

    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.presentedView!.frame.origin.y = self.originY
        }, completion: nil)
     }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView!.roundCorners([.topLeft, .topRight], radius: 22)
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
        originY = self.presentedView!.frame.origin.y

        switch sender.direction {
        case .up:
            originY = self.containerView!.frame.maxY * 0.05
        case .down:
            let newOriginY = Int(self.containerView!.frame.maxY * 0.05)
            if Int(originY) == newOriginY {
                originY = self.containerView!.frame.height * 0.5
            } else {
                originY = self.containerView!.frame.height
            }
        default:
            break
        }

        if self.originY == self.containerView!.frame.height {
            UIView.animate(withDuration: 1, delay: 0.5, animations: {
                self.presentedViewController.dismiss(animated: true, completion: nil)
            })
        } else {
            UIView.animate(withDuration: 0.5) {
                self.presentedView!.frame.origin.y = self.originY
            }
        }
    }
}

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

