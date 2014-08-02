//
//  LifxLight.swift
//  Ra-iOS
//
//  Created by Joe Blau on 8/2/14.
//  Copyright (c) 2014 ra. All rights reserved.
//

import Foundation

class LightLifx: RaLightProtocol {
  
  var on: Bool = false
  var hue: CGFloat = 0.0
  var saturation: CGFloat = 0.0
  var brightness: CGFloat = 0.0
  var alpha: CGFloat = 1.0
  var localNetworkContext: LFXNetworkContext = LFXClient.sharedClient().localNetworkContext
  
  init() {
    
  }
  
  var brand: LightBrand {
  get {
    return .Lifx
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
    return self.stateOn
  }
  set {
    var powerState = Bool(newValue) ? LFXPowerState.On : LFXPowerState.Off
    localNetworkContext.allLightsCollection.setPowerState( powerState )
  }
  }
  
  var color: UIColor? {
  get {
    return self.color
  }
  set {
    newValue?.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
    var color = LFXHSBKColor(hue: hue*360, saturation: saturation, brightness: brightness)
    localNetworkContext.allLightsCollection.setColor(color)
  }
  }
}