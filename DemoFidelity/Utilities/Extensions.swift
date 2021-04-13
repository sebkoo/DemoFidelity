//
//  Extension.swift
//  DemoFidelity
//
//  Created by Ben Koo on 4/12/21.
//

import UIKit

extension UIImageView {
  func download(imageURL: String) {
    DownloadManager.shared.addOp(url: imageURL, imageView: self) { [weak self] (result, imgURL) in
      Dispatcher.onMain {
        switch result {
        case .Success(let img):
          self?.image = img
        case .Failure(_):
          break
        case .Error(_):
          break
        }
      }
    }
  }
}

extension UICollectionView {
  func register(nib: String) {
    self.register(UINib(nibName: nib, bundle: nil), forCellWithReuseIdentifier: nib)
  }
}
