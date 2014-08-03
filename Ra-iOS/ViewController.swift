//
//  ViewController.swift
//  Ra-iOS
//
//  Created by Joe Blau on 8/2/14.
//  Copyright (c) 2014 ra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var userID: NSString = "user1"
  var color: UIColor = UIColor.blackColor()
  var power: Bool = true
  var fb: Firebase!
  var formatter = NSDateFormatter()
  
  var defaults = NSUserDefaults.standardUserDefaults()
  @IBOutlet weak var colorPickerView: HRColorPickerView!
  @IBOutlet weak var powerSwitch: UISwitch!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    fb = Firebase(url: "https://ra.firebaseio.com/users/")
    color = colorPickerView.color
    colorPickerView.addTarget(self, action: "changeColor:", forControlEvents: UIControlEvents.ValueChanged)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func changeColor(pickerView: HRColorPickerView) {
    println("setting color \(pickerView.color)")
    color = pickerView.color
    LightAPI.sharedInstance.firebaseLight.color = pickerView.color
    LightAPI.sharedInstance.lifx.color = pickerView.color
  }
  
  @IBAction func togglePower(sender: UISwitch) {
    power = powerSwitch.on
    LightAPI.sharedInstance.firebaseLight.on = powerSwitch.on
    LightAPI.sharedInstance.lifx.on = powerSwitch.on
  }

  @IBAction func trainML(sender: UIBarButtonItem) {
    // Train ML
    
    // groupID, minute of hour
    
    formatter.dateFormat = "m"
    var minute: Int = formatter.stringFromDate(NSDate()).toInt()!
    var nearestBeacon = "-1"
    if defaults.objectForKey("nearestBeacon") {
      nearestBeacon = defaults.objectForKey("nearestBeacon") as String
    }
    
    var userData = ["beacon":nearestBeacon, "on": power, "color":colorToInt(color), "vector": [1, minute]]
    
    var newPath = fb!.childByAppendingPath(userID)
    newPath!.setValue(userData);
    
    // Write to firebase
//    println(minute)
    
  }
  
  @IBAction func selectUser(sender: UISegmentedControl) {
    switch sender.selectedSegmentIndex {
    case 1: userID = "user2"
    case 2: userID = "user3"
    default: userID = "user1"
    }
    println(userID)
  }
  
  func colorToInt(color: UIColor) -> Int {
    var (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) = (0.0, 0.0, 0.0, 0.0)
    color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    
    var rInt = (Int)(red * 255.0 + 0.5)
    var gInt = (Int)(green * 255 + 0.5)
    var bInt = (Int)(blue * 255 + 0.5)
    
    return rInt << 16 | gInt << 8 | bInt
  }
}

