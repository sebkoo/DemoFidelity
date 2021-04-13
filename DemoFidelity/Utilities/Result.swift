//
//  Result.swift
//  DemoFidelity
//
//  Created by Ben Koo on 4/12/21.
//

import UIKit

enum Result<T> {
  case Success(T)
  case Error(String)
  case Failure(String)
}
