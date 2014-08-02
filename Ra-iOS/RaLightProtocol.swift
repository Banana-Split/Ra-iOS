//
//  RaLightProtocol.swift
//  Ra-iOS
//
//  Created by Joe Blau on 8/2/14.
//  Copyright (c) 2014 ra. All rights reserved.
//

import Foundation

enum LightBrand {
  case Firebase, Lifx
}

protocol RaLightProtocol {
  
  var brand: LightBrand { get }
  var id: String? { get set }
  var stateOn: Bool { get set }
  var color: UIColor? { get set }
}