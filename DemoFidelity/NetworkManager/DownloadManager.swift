//
//  DownloadManager.swift
//  DemoFidelity
//
//  Created by Ben Koo on 4/12/21.
//

import UIKit

typealias ImageClosure = (_ result: Result<UIImage>, _ url: String) -> Void

class DownloadManager: NSObject {
  static let shared = DownloadManager()
  
  private var operationQ = OperationQueue()
  private var dictBlocks = [UIImageView: (String, ImageClosure, DownloadOperation)]()
  
  private override init() {
    operationQ.maxConcurrentOperationCount = 50
  }
  
  func addOp(url: String, imageView: UIImageView, completion: @escaping ImageClosure) {
    if let image = DataCache.shared.getImageCached(key: url)  {
      completion(.Success(image), url)
      if let tupple   = self.dictBlocks.removeValue(forKey: imageView) { tupple.2.cancel() }
    } else {
      if !hasOperation(url: url, completion: completion) {
        if let tupple = self.dictBlocks.removeValue(forKey: imageView) { tupple.2.cancel() }
        
        let newOp = DownloadOperation(url: url) { [weak self] (image,imgURL) in
          guard let self = self else { return }
          
          if let tupple = self.dictBlocks[imageView] {
            if tupple.0 == imgURL {
              if let image = image {
                DataCache.shared.cacheImage(key: imgURL, img: image)
                tupple.1(.Success(image), imgURL)
                if let tupple = self.dictBlocks.removeValue(forKey: imageView) { tupple.2.cancel() }
              } else {
                tupple.1(.Failure("Not fetched"), imgURL)
              }
              _ = self.dictBlocks.removeValue(forKey: imageView)
            }
          }
        }
        dictBlocks[imageView] = (url, completion, newOp)
        operationQ.addOperation(newOp)
      }
    }
  }
  
  func hasOperation(url: String, completion: @escaping ImageClosure) -> Bool {
    if let arrayOperation = operationQ.operations as? [DownloadOperation] {
      let opeartions = arrayOperation.filter{$0.url == url}
      return opeartions.count > 0 ? true : false
    }
    
    return false
  }
}
