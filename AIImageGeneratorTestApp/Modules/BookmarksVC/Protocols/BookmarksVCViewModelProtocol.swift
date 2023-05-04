//
//  BookmarksVCViewModelProtocol.swift
//  AIImageGeneratorTestApp
//
//  Created by Eugene Kudritsky on 3.05.23.
//

import Foundation

protocol BookmarksVCViewModelProtocol {
  var imageModel: [ImageModel] { get set }
  var bookmarkManager: BookmarkManagerProtocol { get set }
  func viewWillAppear()
}
