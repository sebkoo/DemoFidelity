//
//  RequestMethod.swift
//  DemoFidelity
//
//  Created by Ben Koo on 4/12/21.
//

import Foundation

enum RequestMethod: String {
  case get  = "GET"
  case post = "POST"
  case put  = "PUT"
  
  var value: String {
    return self.rawValue
  }
}
