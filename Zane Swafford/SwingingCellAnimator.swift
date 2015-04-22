//
//  SwingingCellAnimator.swift
//  Zane Swafford
//
//  Created by Zane Swafford on 4/22/15.
//  Copyright (c) 2015 Zane Swafford. All rights reserved.
//
import UIKit
import QuartzCore

let SwingingCellAnimatorStartTransform:CATransform3D = {
        let rotationDegrees: CGFloat = 15.0
        let rotationRadians: CGFloat = rotationDegrees * (CGFloat(M_PI)/180.0)
        let offset = CGPointMake(-20, 20)
        var startTransform = CATransform3DIdentity
        startTransform = CATransform3DRotate(CATransform3DIdentity,
            rotationRadians, 0.0, 0.0, 1.0)
        startTransform = CATransform3DTranslate(startTransform, offset.x, offset.y, 0.0)
        
        return startTransform
    }()

class SwingingCellAnimator {
    class func animateIntro(cell:UITableViewCell) {
        let view = cell.contentView
        
        view.layer.transform = SwingingCellAnimatorStartTransform
        view.layer.opacity = 0.8
        
        UIView.animateWithDuration(0.4) {
            view.layer.transform = CATransform3DIdentity
            view.layer.opacity = 1
        }
    }
    
    class func animateGravity(cell:UITableViewCell, gravity:CGPoint) {
        let view = cell.contentView
        
        let rotationDegrees: CGFloat = 15.0
        let rotationRadians: CGFloat = rotationDegrees * (CGFloat(M_PI)/180.0)
        let offset = gravity
        
        var transform = CATransform3DIdentity
        transform = CATransform3DRotate(CATransform3DIdentity,
            rotationRadians, 0.0, 0.0, 1.0)
        transform = CATransform3DTranslate(transform, offset.x, offset.y, 0.0)
        
        view.layer.transform = transform
        
        UIView.animateWithDuration(0.4) {
            view.layer.transform = CATransform3DIdentity
        }
    }
}