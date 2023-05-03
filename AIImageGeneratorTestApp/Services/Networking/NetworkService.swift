//
//  NetworkService.swift
//  AIImageGeneratorTestApp
//
//  Created by Eugene Kudritsky on 2.05.23.
//

import UIKit

private enum APIBaseURL {
  static let apiBaseURL = "https://dummyimage.com/300x300&text="

}

final class NetworkService: NetworkServiceProtocol {

  //MARK: - Load image data

  func loadImageData(with text: String, completion: @escaping (Result<Data, Error>) -> Void) {
    self.createRequest(with: URL(string: "\(APIBaseURL.apiBaseURL)\(text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"), type: .GET) { request in
      let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else { return }
        completion(.success(data))
      }
      task.resume()
    }
  }
}

//MARK: - Create Request

extension NetworkService {
  private func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping (URLRequest) -> Void) {
    guard let apiURL = url else { return }
    var request = URLRequest(url: apiURL)
    request.httpMethod = type.rawValue
    request.timeoutInterval = 30
    completion(request)
  }
}
