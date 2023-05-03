//
//  GenerateImageViewModel.swift
//  AIImageGeneratorTestApp
//
//  Created by Eugene Kudritsky on 2.05.23.
//

import Foundation

final class GenerateImageViewModel {

  //MARK: - Properties

  private let networkService: NetworkServiceProtocol
  var imageModel: [ImageModel]
  private let bookmarksManager: BookmarkManagerProtocol
 

  //MARK: - Init

  init(networkService: NetworkServiceProtocol, imageModel: [ImageModel], bookmarksManager: BookmarkManagerProtocol) {
    self.networkService = networkService
    self.imageModel = imageModel
    self.bookmarksManager = bookmarksManager
  }



}

extension GenerateImageViewModel: GenerateImageViewModelProtocol {
  func fetchData(with text: String, completion: @escaping (Bool) -> Void) {
    if !bookmarksManager.isBookmarkImageExist(withName: text) {
      networkService.loadImageData(with: text) { result in
        switch result {
        case .success(let model):
          self.imageModel.append(ImageModel(
            title: text,
            image: model
          ))
          completion(true)
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    } else {
      completion(false)
    }
  }

  func saveImage(with text: String, and image: Data, completion: @escaping (Bool) -> Void) {
    if bookmarksManager.isBookmarkImageExist(withName: text) {
      completion(true)
    } else {
      self.bookmarksManager.saveBookmarkImage(image, withName: text)
      completion(false)
    }

  }
}




