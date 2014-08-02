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
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//      var url = NSURL(string: "http://ip-api.com/line/?fields=query")
//      var ip = NSString(data: NSData(contentsOfURL: url), encoding: NSUTF8StringEncoding) as String
////      var location = ip.digest(.SHA1, key: "ra")
//      var location = "testlight"
//      dispatch_async(dispatch_get_main_queue(), {
//        self.fb = Firebase(url: "https://ra.firebaseio.com/devices/virtualbulb/\(location)")
//        self.fb.observeEventType(FEventTypeValue, withBlock: { snapshot in
//          self.fb.removeAllObservers()
//          var lightStateObject = snapshot.value as Dictionary<String, AnyObject>
////          NSNotificationCenter.defaultCenter().postNotificationName("UPDATE_LIGHTS", object: nil, userInfo: lightStateObject)
//          
//          })
//        })
//      })
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
    fb.setValue(["on": true, "h": hue, "s": saturation, "b": brightness, "a": alpha])
  }
  }
}
