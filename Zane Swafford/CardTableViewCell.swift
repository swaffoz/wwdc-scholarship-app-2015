//
//  CardTableViewCell.swift
//  Zane Swafford
//
//  Created by Zane Swafford on 4/22/15.
//  Copyright (c) 2015 Zane Swafford. All rights reserved.
//

import UIKit
import QuartzCore

class CardTableViewCell: UITableViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var cardTextView: UITextView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func useCard(card:Card) {
        if let coverPhotoName = card.coverPhotoName {
            self.coverImageView.image = UIImage(named: coverPhotoName)
        }
        
        if let cardText = card.text,
           let merriweather = UIFont(name: "MerriweatherSans-Bold", size: 19) {
            let attributes = [NSTextEffectAttributeName: NSTextEffectLetterpressStyle,
                                    NSFontAttributeName: merriweather,
                         NSForegroundColorAttributeName: UIColor.grayishColor()]
            
            self.cardTextView.attributedText = NSAttributedString(string: cardText, attributes: attributes)
        }
        
        if let backgroundImage = UIImage(named: "creampaper") {
            self.cardView.backgroundColor = UIColor(patternImage: backgroundImage)
            self.cardView.opaque = true
            self.cardView.layer.opaque = true
        }
    }
}
