//
//  LightAPI.swift
//  Ra-iOS
//
//  Created by Joe Blau on 8/2/14.
//  Copyright (c) 2014 ra. All rights reserved.
//

import UIKit

class LightAPI: NSObject {
  
  let firebaseLight = FirebaseLight()
//  let philipsHue = LightPhilipsHue()
  let lifx = LightLifx()
  
  class var sharedInstance : LightAPI {
  struct Static {
    static let instance : LightAPI = LightAPI()
    }
    return Static.instance
  }
}
