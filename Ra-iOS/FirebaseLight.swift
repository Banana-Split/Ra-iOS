//
//  FirebaseLight.swift
//  Ra-iOS
//
//  Created by Joe Blau on 8/2/14.
//  Copyright (c) 2014 ra. All rights reserved.
//

import UIKit

class FirebaseLight: RaLightProtocol {
  var on: Bool = false
  var hue: CGFloat = 0.0
  var saturation: CGFloat = 0.0
  var brightness: CGFloat = 0.0
  var alpha: CGFloat = 1.0
  var fb: Firebase!
  
  init() {
    var location = "testlight"
    self.fb = Firebase(url: "https://ra.firebaseio.com/devices/virtualbulb/\(location)")
  }

  var brand: LightBrand {
  get {
    return .Firebase
  }
  }
  
  var id: String? {
  get {
    return self.id
  }
  set {
    
  }
  }
  
  var stateOn: Bool {
  get {
    return self.on
  }
  set {
    fb.setValue(["on": newValue, "h": hue, "s": saturation, "b": brightness, "a": alpha])
  }
  }
  
  var color: UIColor? {
  get {
    return self.color
  }
  set {
    newValue?.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
    var hexColor = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha).RGBHexString()
    fb.setValue(["on": true, "h": hue, "s": saturation, "b": brightness, "a": alpha, "hex": "#\(hexColor)"])
  }
  }
}
