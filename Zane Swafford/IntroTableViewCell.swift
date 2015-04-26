//
//  IntroTableViewCell.swift
//  Zane Swafford
//
//  Created by Zane Swafford on 4/25/15.
//  Copyright (c) 2015 Zane Swafford. All rights reserved.
//

import UIKit

class IntroTableViewCell: UITableViewCell {
    @IBOutlet weak var howdyLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var downImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        howdyLabel.frame.origin.y += 300
        howdyLabel.alpha = 0
        howdyLabel.hidden = false
        
        //nameLabel.frame.origin.y += 300
        nameLabel.alpha = 0
        nameLabel.hidden = false
        
        downImage.alpha = 0
        downImage.hidden = false
        
        UIView.animateWithDuration(0.5) {
            self.howdyLabel.frame.origin.y -= 300
            self.howdyLabel.alpha = 1
        }
        UIView.animateWithDuration(0.5, delay: 0.5, options: nil, animations: {self.nameLabel.alpha = 1}, completion: nil)
        UIView.animateWithDuration(0.5, delay: 0.5, options: nil, animations: {self.downImage.alpha = 0.8}, completion: nil)
        
        downImage.layoutIfNeeded()
        
        var textImage = UIImage(named:"down")
        var textWidth = downImage.bounds.width
        var textHeight = downImage.bounds.height
        
        var textLayer = CALayer()
        textLayer.contents = textImage!.CGImage
        textLayer.frame = CGRect(x: self.contentView.bounds.midX, y: self.contentView.bounds.maxY, width: textWidth, height: textHeight)
        
        var maskLayer = CALayer()
        
        maskLayer.backgroundColor = UIColor(red:0.0, green:0.0, blue:0.0, alpha:0.15).CGColor
        maskLayer.contents = UIImage(named:"Mask")!.CGImage
        maskLayer.contentsGravity = kCAGravityBottom
        maskLayer.frame = CGRectMake(0, textHeight, textWidth, textHeight)
        
        var maskAnim = CABasicAnimation(keyPath: "position.y")
        maskAnim.byValue = -textWidth
        maskAnim.repeatCount = Float.infinity
        maskAnim.duration = 1.2
        maskLayer.addAnimation(maskAnim, forKey:"slideAnimation")
        
        textLayer.mask = maskLayer;
        downImage.layer.addSublayer(textLayer)
    }
}
