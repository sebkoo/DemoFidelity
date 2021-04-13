//
//  ImageViewModel.swift
//  DemoFidelity
//
//  Created by Ben Koo on 4/12/21.
//

import UIKit

struct ImageViewModel {
  
  let imageURL: String
  
  init(withPhotos result: AnimeData) {
    imageURL = result.image_url
  }
}
