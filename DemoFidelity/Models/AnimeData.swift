//
//  AnimeData.swift
//  DemoFidelity
//
//  Created by Ben Koo on 4/12/21.
//

import Foundation

class AnimeData: Decodable {
  var mal_id: Int
  var url: String
  var image_url: String
  var title: String
  var airing: Bool
  var synopsis: String
  var type: String
  var episodes: Int
  var score: Double
  var start_date: String?
  var end_date: String?
  var members: Int
  var rated: String?
}
