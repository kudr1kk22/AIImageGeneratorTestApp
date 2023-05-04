//
//  GenerateImageViewModelProtocol.swift
//  AIImageGeneratorTestApp
//
//  Created by Eugene Kudritsky on 2.05.23.
//

import Foundation

protocol GenerateImageViewModelProtocol {
  func fetchData(with text: String, completion: @escaping (Bool) -> Void)
  var imageModel: [ImageModel] { get set }
  func saveImage(with text: String, and image: Data, completion: @escaping (Bool) -> Void)
  func viewWillAppear()
}
