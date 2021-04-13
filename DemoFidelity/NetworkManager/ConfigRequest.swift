//
//  RequestConfig.swift
//  DemoFidelity
//
//  Created by Ben Koo on 4/12/21.
//

import UIKit

enum ConfigRequest {
  case searchRequest(String)
  
  var value: Request? {
    switch self {
    case .searchRequest(let searchText):
      let endPt = String(format: EndPoint.searchURL, searchText)
      return Request.init(method: .get, url: endPt)
    }
  }
}
