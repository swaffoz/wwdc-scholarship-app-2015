//
//  AppDelegate.swift
//  Zane Swafford
//
//  Created by Zane Swafford on 4/22/15.
//  Copyright (c) 2015 Zane Swafford. All rights reserved.
//

import UIKit
import CoreMotion

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var manager = CMMotionManager()
    lazy var queue = NSOperationQueue()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
        
        if manager.gyroAvailable{
            
            if manager.gyroActive == false{
                
                manager.gyroUpdateInterval = 1.0 / 20.0
                
                manager.startGyroUpdatesToQueue(queue,
                    withHandler: {(data: CMGyroData!, error: NSError!) in
                        
                        //println("Gyro Rotation x = \(data.rotationRate.x)")
                        //println("Gyro Rotation y = \(data.rotationRate.y)")
                        println("Gyro Rotation z = \(data.rotationRate.z)")
                        
                })
                
            } else {
                println("Gyro is already active")
            }
            
        } else {
            println("Gyro isn't available")
        }
        
        return true
    }
}

