//
//  UIViewHelpers.swift
//  Zane Swafford
//
//  Created by Zane Swafford on 4/22/15.
//  Copyright (c) 2015 Zane Swafford. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: Parallax Effects
    func addParallaxWithOffsets(xOffset: CGFloat = 10.0, yOffset: CGFloat = 10.0) {
        var horizontalEffect = UIInterpolatingMotionEffect(keyPath: "center.x",
            type: .TiltAlongHorizontalAxis)
        horizontalEffect.minimumRelativeValue = xOffset
        horizontalEffect.maximumRelativeValue = -xOffset
        
        var verticalEffect = UIInterpolatingMotionEffect(keyPath: "center.y",
            type: .TiltAlongVerticalAxis)
        verticalEffect.minimumRelativeValue = yOffset
        verticalEffect.maximumRelativeValue = -yOffset
        
        var horizontalShadowEffect = UIInterpolatingMotionEffect(keyPath: "layer.shadowOffset.width",
            type: .TiltAlongHorizontalAxis)
        horizontalShadowEffect.minimumRelativeValue = xOffset * 0.5
        horizontalShadowEffect.maximumRelativeValue = -xOffset * 0.5
        
        var verticalShadowEffect = UIInterpolatingMotionEffect(keyPath: "layer.shadowOffset.height",
            type: .TiltAlongVerticalAxis)
        verticalShadowEffect.minimumRelativeValue = yOffset * 0.5
        verticalShadowEffect.maximumRelativeValue = -yOffset * 0.5
        
        var group = UIMotionEffectGroup()
        group.motionEffects = [horizontalEffect, verticalEffect, horizontalShadowEffect, verticalShadowEffect]
        addMotionEffect(group)
    }
    
    func removeMotionEffects() {
        if let effects = self.motionEffects {
            for effect in effects {
                self.removeMotionEffect((effect as! UIMotionEffect))
            }
        }
    }
}