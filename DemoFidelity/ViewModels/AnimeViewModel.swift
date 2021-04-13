//
//  AnimeViewModel.swift
//  DemoFidelity
//
//  Created by Ben Koo on 4/12/21.
//

import UIKit

class AnimeViewModel: NSObject {
  private var searchText = ""
  public var dataSource = [CellViewModel]()
  
  var alert: ((String) -> Void)?
  var newData: (() -> Void)?
  
  func search(text: String, completion:@escaping () -> Void) {
    searchText = text
    fetchResults(completion: completion)
  }
  
  private func fetchResults(completion:@escaping () -> Void) {
    SearchService().request(searchText) { [weak self] output in
      guard let self = self else { return }
      Dispatcher.onMain {
        switch output {
        case .Success(let results):
          if let result = results {
            self.dataSource = result.results.map{
              CellViewModel(result: $0)
            }
            self.newData?()
            
          }
          completion()
        case .Failure(let message):
          self.alert?(message)
          completion()
        case .Error(let error):
          self.alert?(error)
          completion()
        }
      }
    }
  }
  
}
