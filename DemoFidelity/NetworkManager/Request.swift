//
//  Request.swift
//  DemoFidelity
//
//  Created by Ben Koo on 4/12/21.
//

import UIKit

class Request: NSMutableURLRequest {
  convenience init?(method: RequestMethod, url: String, body: [String: Any]? = nil) {
    guard let url =  URL.init(string: url) else { return nil }
    
    self.init(url: url)
    
    do {
      if let body = body {
        let data = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        self.httpBody = data
      }
    } catch { }
    
    self.httpMethod = method.value
    self.addValue("application/json", forHTTPHeaderField: "Content-Type")
  }
}
