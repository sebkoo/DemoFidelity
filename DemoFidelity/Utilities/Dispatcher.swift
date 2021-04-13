//
//  Dispatcher.swift
//  DemoFidelity
//
//  Created by Ben Koo on 4/12/21.
//

import UIKit

class Dispatcher {
  static func onMain(closure: @escaping () -> Void) {
    DispatchQueue.main.async {
      closure()
    }
  }
  static func onGlobal(closure: @escaping () -> Void) {
    DispatchQueue.global(qos: .userInitiated).async {
      closure()
    }
  }
}
