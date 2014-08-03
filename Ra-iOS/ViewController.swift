//
//  ViewController.swift
//  Ra-iOS
//
//  Created by Joe Blau on 8/2/14.
//  Copyright (c) 2014 ra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var colorPickerView: HRColorPickerView!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
//    colorPicker = HRColorPickerView()
    
    colorPickerView.addTarget(self, action: "changeColor:", forControlEvents: UIControlEvents.ValueChanged)
//    self.view.addSubview(colorPicker)
    

    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func changeColor(pickerView: HRColorPickerView) {
    println("setting color \(pickerView.color)")
    LightAPI.sharedInstance.firebaseLight.color = pickerView.color
    LightAPI.sharedInstance.lifx.color = pickerView.color
  }
  

}

