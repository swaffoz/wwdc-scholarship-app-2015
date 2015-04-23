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
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)

        return true
    }
}

