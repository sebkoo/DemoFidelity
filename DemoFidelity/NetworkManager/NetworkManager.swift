//
//  NetworkManager.swift
//  DemoFidelity
//
//  Created by Ben Koo on 4/12/21.
//

import UIKit

class NetworkManager: NSObject {
  
  static let shared = NetworkManager()
  static let errMsg = "ERROR: please try it again later on."
  
  func request(_ request: Request, completion: @escaping (Result<Data>) -> Void) {
    URLSession.shared.dataTask(with: request as URLRequest) { data, response, err in
      guard err == nil else {
        return completion(.Failure(err!.localizedDescription))
      }
      
      guard let data = data else {
        return completion(.Failure(err?.localizedDescription ?? NetworkManager.errMsg))
      }
      
      guard let response = String(data: data, encoding: String.Encoding.utf8) else {
        return completion(.Failure(err?.localizedDescription ?? NetworkManager.errMsg))
      }
      
      print("Respone: \(response)")
      
      return completion(.Success(data))
      
    }.resume()
  }
  
  func download(imgURL: String, completion: @escaping (Result<UIImage>) -> Void) {
    let config  = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    
    guard let url =  URL.init(string: imgURL) else {
      return completion(.Failure(NetworkManager.errMsg))
    }
    
    session.downloadTask(with: url) { url, reponse, error in
      do {
        guard let url = url else { return completion (
          .Failure(NetworkManager.errMsg) ) }
        
        let data = try Data(contentsOf: url)
        
        if let image = UIImage(data: data) { return completion (
          .Success(image) )
        } else { return completion(
          .Failure(NetworkManager.errMsg) )
        }
      } catch { return completion (
        .Error(NetworkManager.errMsg) ) }
    }.resume()
  }
}
