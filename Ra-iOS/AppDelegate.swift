//
//  AppDelegate.swift
//  Ra-iOS
//
//  Created by Joe Blau on 8/2/14.
//  Copyright (c) 2014 ra. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
                            
  var window: UIWindow?
  
  var beaconRegion: CLBeaconRegion?
  var defaults = NSUserDefaults.standardUserDefaults()
  var locationManager: CLLocationManager = CLLocationManager()
  var nearestBeacon: String?
  var proximity: Float?
  var brains: Array<Brain>!

  func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
    // Override point for customization after application launch.
    locationManager.pausesLocationUpdatesAutomatically = true
    locationManager.requestAlwaysAuthorization()
    locationManager.delegate = self
    
    var uuid = NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")
    beaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: "Region")
    beaconRegion!.notifyEntryStateOnDisplay = true
    
    locationManager.startMonitoringForRegion(beaconRegion)
    locationManager.startRangingBeaconsInRegion(beaconRegion)
    
    var newBrain = Brain()
    newBrain.learn(4, proxmity: 1, on: true, r: 0, g: 0, b: 0)
    newBrain.learn(1, proxmity: 2, on: false, r: 0, g: 0, b: 0)
    newBrain.learn(2, proxmity: 2, on: false, r: 0, g: 0, b: 0)
    
    newBrain.train()
    
    println(newBrain.decide(1, proxmity: 2));
    return true
  }

  func applicationWillResignActive(application: UIApplication!) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication!) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication!) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication!) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication!) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
  
  // Location Delegates
  func locationManager(manager: CLLocationManager!, didDetermineState state: CLRegionState, forRegion region: CLRegion!) {
    switch state {
    case .Inside: println("locationManager didDetermineState INSIDE for \(region.identifier)")
    case .Outside: println("locationManager didDetermineState OUTSIDE for \(region.identifier)")
    default: println("locationManager didDetermineState OTHER for \(region.identifier)")
    }
  }
  
  func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {

//    if defaults.boolForKey("homeMachineLearningOn") {
      if (beacons.count > 0){
//        println("we made it \(beacons.count)")
        for beacon in beacons as [CLBeacon] {
//          println("beacon \(beacon)")
          switch beacon.proximity {
          case .Immediate, .Near: proximity = 1.0
          case .Far: proximity = 0.0
          default: nearestBeacon = nil; continue
          }
          nearestBeacon = "\(beacon.major)+\(beacon.minor)"
          //          println("Beacon: \(nearestBeacon) \\ Proximity: \(proximity)")

          //          println("Action: \(action)")
//          switch action {
//          case 1.0: LightAPI.sharedInstance.lifx.stateOn = true
//          case -1.0:  LightAPI.sharedInstance.lifx.stateOn = false
//          default: continue
//          }
        }
      }
//    }
  }
  
  func locationManager(manager: CLLocationManager!, didStartMonitoringForRegion region: CLRegion!) {
    println("monitroing")
    //    locationManager.startRangingBeaconsInRegion(beaconRegion!)
  }
  
  func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
    //    println("didEnterRegion")
  }
  
  func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
    //    println("didExitRegion")
  }



}

