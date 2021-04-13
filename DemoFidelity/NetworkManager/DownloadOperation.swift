//
//  DownloadOperation.swift
//  DemoFidelity
//
//  Created by Ben Koo on 4/12/21.
//

import UIKit

typealias ImageCompletion = (_ image : UIImage?, _ url : String) -> Void

class DownloadOperation: Operation {
  let url: String?
  var customBlock: ImageCompletion?
  
  init (url: String, completion: @escaping ImageCompletion) {
    self.url = url
    self.customBlock = completion
  }
  
  override func main() {
    if self.isCancelled { return }
  
    if let url = self.url {
      if self.isCancelled { return }
      
      NetworkManager.shared.download(imgURL: url) { result in
        Dispatcher.onMain {
          switch result {
          case .Success(let img):
            if self.isCancelled { return }
            if let completion = self.customBlock { completion(img, url) }
          default:
            if self.isCancelled { return }
            break
          }
        }
      }
    }
  }
}
