//
//  NetworkServiceProtocol.swift
//  AIImageGeneratorTestApp
//
//  Created by Eugene Kudritsky on 2.05.23.
//

import UIKit

protocol NetworkServiceProtocol {
  func loadImageData(with text: String, completion: @escaping (Result<Data, Error>) -> Void)
}
