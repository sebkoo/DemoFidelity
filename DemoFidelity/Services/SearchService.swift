//
//  SearchService.swift
//  DemoFidelity
//
//  Created by Ben Koo on 4/12/21.
//

import UIKit

class SearchService: NSObject {
  func request(_ searchText: String, completion: @escaping (Result<AnimeSearch?>) -> Void) {
    guard let request = ConfigRequest.searchRequest(searchText).value else { return }
    
    NetworkManager.shared.request(request) { result in
      switch result {
      case .Error(let err):
        return completion(.Failure(err))
      case .Failure(let msg):
        return completion(.Failure(msg))
      case .Success(let input):
        if let model = self.process(response: input) {
          if let status = model.request_cached, status == true {
            return completion(.Success(model))
          } else { return completion(.Failure(NetworkManager.errMsg)) }
        }   else { return completion(.Failure(NetworkManager.errMsg)) }
      }
    }
  }
  
  func process(response: Data) -> AnimeSearch? {
    do {
      let output = try JSONDecoder().decode(AnimeSearch.self, from: response)
      return output
    } catch {
      print("Data parsing error: \(error)")
      return nil
    }
  }
}
