//
//  AnimeSearch.swift
//  DemoFidelity
//
//  Created by Ben Koo on 4/12/21.
//

import UIKit

struct AnimeSearch: Decodable {
  let request_hash: String
  let request_cached: Bool?
  let request_cache_expiry: Int
  let results: [AnimeData]
  let last_page: Int
}
