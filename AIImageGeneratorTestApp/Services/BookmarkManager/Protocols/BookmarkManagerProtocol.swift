//
//  BookmarkManagerProtocol.swift
//  AIImageGeneratorTestApp
//
//  Created by Eugene Kudritsky on 3.05.23.
//

import Foundation

protocol BookmarkManagerProtocol {
  func isBookmarkImageExist(withName name: String) -> Bool
  func saveBookmarkImage(_ image: Data, withName name: String)
  func getBookmarkImage(with name: String) -> Data?
}
