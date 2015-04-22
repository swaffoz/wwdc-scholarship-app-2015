//
//  CardTableViewController.swift
//  Zane Swafford
//
//  Created by Zane Swafford on 4/22/15.
//  Copyright (c) 2015 Zane Swafford. All rights reserved.
//

import UIKit

class CardTableViewController: UITableViewController {
    var cards: [Card] = []
    var preventAnimation = Set<NSIndexPath>()
    
    func loadCards() {
        let path = NSBundle.mainBundle().pathForResource("Cards", ofType: "json")
        cards = Card.loadCardsFromFile(path!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITableView.appearance().backgroundColor = UIColor.clearColor()
        
        tableView.backgroundView = UIView()
        let colorOne = UIColor(red:(120/255.0), green:(135/255.0), blue:(150/255.0), alpha:1.0)
        let colorTwo = UIColor(red:(57/255.0),  green:(79/255.0),  blue:(96/255.0),  alpha:1.0)
        let colorThree = UIColor(hue:0.625, saturation:0.0, brightness:0.7, alpha:1.0)
        let colorFour = UIColor(hue:0.625, saturation:0.0, brightness:0.4, alpha:1.0)
        
        let colors =  [colorOne.CGColor, colorTwo.CGColor]//, colorThree.CGColor, colorFour.CGColor]
        
        let locations = [0.0, 1.0]//[0.0, 0.02, 0.99, 1.0];
        
        var gradient = CAGradientLayer()
        gradient.frame = tableView.backgroundView!.bounds
        gradient.colors = colors//[UIColor.blackColor().CGColor, UIColor.grayColor().CGColor]
        tableView.backgroundView!.layer.insertSublayer(gradient, atIndex: 0)
        gradient.locations = locations
        tableView.backgroundView!.layoutSubviews()
        
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        
        loadCards();
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if !preventAnimation.contains(indexPath) {
            preventAnimation.insert(indexPath)
            SwingingCellAnimator.animateIntro(cell)
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CardTableViewCell", forIndexPath: indexPath) as! CardTableViewCell
        let card = cards[indexPath.row]
        cell.useCard(card)
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        if let bgGradient = tableView.backgroundView?.layer.sublayers[0] as? CALayer,
           let bgView = tableView.backgroundView{
            bgGradient.frame = bgView.bounds
        }
    }
}
