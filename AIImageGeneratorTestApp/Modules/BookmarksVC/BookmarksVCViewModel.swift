//
//  BookmarksVCViewModel.swift
//  AIImageGeneratorTestApp
//
//  Created by Eugene Kudritsky on 3.05.23.
//

import Foundation

final class BookmarksVCViewModel: BookmarksVCViewModelProtocol {
  
  //MARK: - Properties

  var imageModel: [ImageModel] = []
  var bookmarkManager: BookmarkManagerProtocol

  //MARK: - Initialization

  init(bookmarkManager: BookmarkManagerProtocol) {
    self.bookmarkManager = bookmarkManager
  }

  //MARK: - Methods

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



