//
//  CellViewModel.swift
//  DemoFidelity
//
//  Created by Ben Koo on 4/12/21.
//

import Foundation

class CellViewModel {
  
  let imageURL: String
  let title: String
  let type: String
  let synopsis: String
  
  init(result: AnimeData) {
    self.imageURL = result.image_url
    self.title = result.title
    self.type = result.type
    self.synopsis = result.synopsis
  }
  
}
