//
//  ViewController.swift
//  Ra-iOS
//
//  Created by Joe Blau on 8/2/14.
//  Copyright (c) 2014 ra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
//  @IBOutlet weak var brightnessSlider: HRBrightnessSlider!
//  @IBOutlet weak var colorInfo: HRColorInfoView!
//  @IBOutlet weak var colorMapView: HRColorMapView!

  @IBOutlet weak var colorPickerView: HRColorPickerView!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
//    colorPicker = HRColorPickerView()
    
    colorPickerView.addTarget(self, action: "changeColor:", forControlEvents: UIControlEvents.ValueChanged)
//    self.view.addSubview(colorPicker)
    
//    colorMapView.tileSize = 16
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func changeColor(pickerView: HRColorPickerView) {
    println("boom \(pickerView.color)")
//    var (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) = (0.0, 0.0, 0.0, 0.0)
//    pickerView.color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
//    
    
    LightAPI.sharedInstance.firebaseLight.color = pickerView.color
  }
  

}

