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
  var imageModel: [ImageModel] = []
  private let bookmarksManager: BookmarkManagerProtocol
  private let imagesLimit = 4

  //MARK: - Init

  init(networkService: NetworkServiceProtocol, bookmarksManager: BookmarkManagerProtocol) {
    self.networkService = networkService
    self.bookmarksManager = bookmarksManager
  }
}

//MARK: - Fetch data image

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

  //MARK: - Save image
  
  func saveImage(with text: String, and image: Data, completion: @escaping (Bool) -> Void) {
    if bookmarksManager.isBookmarkImageExist(withName: text) {
      completion(true)
    } else {
      checkImageLimit()
      self.bookmarksManager.saveBookmarkImage(image, withName: text)
      completion(false)
    }
  }

  //MARK: - Check image limit

  func checkImageLimit() {
    if imageModel.count == imagesLimit {
      let oldestImage = imageModel.first
      bookmarksManager.deleteBookmarkImage(with: oldestImage?.title ?? "")
      imageModel.removeFirst()
    }
  }

  func fetchFromCoreData() -> [ImageModel] {
    let request = ImageCoreDataModel.fetchRequest()
    let imagesCoreData = try? CoreDataService.context.fetch(request)
    guard let image = imagesCoreData.map({ model in
      model.map { model in
        ImageModel(title: model.title,
                   imagePath: model.imagePath)
      }
    }) else { return [] }

    return image
  }

  func viewWillAppear() {
    imageModel = fetchFromCoreData()
  }
}
