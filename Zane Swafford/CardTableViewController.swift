//
//  CardTableViewController.swift
//  Zane Swafford
//
//  Created by Zane Swafford on 4/22/15.
//  Copyright (c) 2015 Zane Swafford. All rights reserved.
//

import UIKit
import CoreMotion

class CardTableViewController: UITableViewController {
    var manager: CMMotionManager?
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
        
        let colors =  [colorOne.CGColor, colorTwo.CGColor]
        let locations = [0.0, 1.0]
        
        var gradient = CAGradientLayer()
        gradient.frame = tableView.backgroundView!.bounds
        gradient.colors = colors
        tableView.backgroundView!.layer.insertSublayer(gradient, atIndex: 0)
        gradient.locations = locations
        
        tableView.estimatedRowHeight = 360
        tableView.rowHeight = UITableViewAutomaticDimension
        
        loadCards()
        setupGyroscope()
        //setupParallax()
    }

    // MARK: UITableView
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if !preventAnimation.contains(indexPath) {
            preventAnimation.insert(indexPath)
        }
        
        if let firstCell = self.tableView.visibleCells().first as? UITableViewCell {
            if let topIndexPath = tableView.indexPathForCell(firstCell) {
                if (indexPath.row > topIndexPath.row) {
                    SwingingCellAnimator.animateIntroUp(cell)
                } else {
                    SwingingCellAnimator.animateIntroDown(cell)
                }
            }
        }
            //cell.addParallaxWithOffsets(xOffset: -6, yOffset: -6)
        //}
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 && !preventAnimation.contains(indexPath) {
            return self.view.bounds.height
        } else if indexPath.row == 0 && preventAnimation.contains(indexPath) {
            return 160
        } else if indexPath.row == cards.count+1 {
            return 260
        } else {
            return 360
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count + 2
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("Intro", forIndexPath: indexPath) as! IntroTableViewCell
            return cell
        } else if indexPath.row > cards.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("Outro", forIndexPath: indexPath) as! UITableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("Card", forIndexPath: indexPath) as! CardTableViewCell
            let card = cards[indexPath.row-1]
            cell.useCard(card)
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    // MARK: Gyroscope
    func setupGyroscope() {
        manager = CMMotionManager()
        if manager!.deviceMotionAvailable {
            manager!.deviceMotionUpdateInterval = 0.01
            manager!.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue()) {
                [weak self] (data: CMDeviceMotion!, error: NSError!) in
                var rotation = atan2(data.gravity.x, 1) * -0.16
                
                for cell in self?.tableView.visibleCells() as! [CardTableViewCell] {
                    cell.cardView.transform = CGAffineTransformMakeRotation(CGFloat(rotation))
                }
            }
        } else {
            println("No device motion 😦")
        }
    }
    
    // MARK: Parallax
    func setupParallax() {
        for cell in self.tableView.visibleCells() as! [CardTableViewCell] {
            cell.addParallaxWithOffsets(xOffset: 20, yOffset: 20)
        }
    }
    
    // MARK: Rotation Animation
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        if let bgGradient = tableView.backgroundView?.layer.sublayers[0] as? CALayer,
           let bgView = tableView.backgroundView{
            bgGradient.frame = bgView.bounds
        }
    }
}
