//
//  BookmarksTableViewCellVM.swift
//  AIImageGeneratorTestApp
//
//  Created by Eugene Kudritsky on 4.05.23.
//

import Foundation

final class BookmarksTableViewCellVM {

  var bookmarkManager: BookmarkManagerProtocol
  var imageModel: ImageModel

  init(bookmarkManager: BookmarkManagerProtocol, imageModel: ImageModel) {
    self.bookmarkManager = bookmarkManager
    self.imageModel = imageModel
  }

}
