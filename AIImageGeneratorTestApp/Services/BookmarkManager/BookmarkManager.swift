//
//  BookmarkManager.swift
//  AIImageGeneratorTestApp
//
//  Created by Eugene Kudritsky on 3.05.23.
//

import Foundation

final class BookmarkManager: BookmarkManagerProtocol {

  //MARK: - Properties

  private let bookmarkDirectoryName = "BookmarkImages"
  private let fileManager = FileManager.default

  private var bookmarkDirectoryURL: URL? {
    guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
      return nil
    }
    let bookmarkDirectory = documentDirectory.appendingPathComponent(bookmarkDirectoryName, isDirectory: true)
    if !fileManager.fileExists(atPath: bookmarkDirectory.path) {
      do {
        try fileManager.createDirectory(at: bookmarkDirectory, withIntermediateDirectories: true, attributes: nil)
      } catch {
        print(error.localizedDescription)
        return nil
      }
    }
    return bookmarkDirectory
  }

  func saveBookmarkImage(_ image: Data, withName name: String) {
    guard let directory = bookmarkDirectoryURL else {
      return
    }
    let fileURL = directory.appendingPathComponent("\(name).jpg")
    do {
      try image.write(to: fileURL)
      // Сохраняем путь до файла в Core Data
         let imagePathString = fileURL.absoluteString
         saveToCoreData(title: name, imagePath: imagePathString)
    } catch {
      print(error.localizedDescription)
    }
  }

  func saveToCoreData(title: String, imagePath: String) {
    let context = CoreDataService.context
    context.perform {
      let newImage = ImageCoreDataModel(context: context)
      newImage.title = title
      newImage.imagePath = imagePath
      CoreDataService.saveContext()
    }
  }

  func deleteBookmarkImage(withName name: String) -> Bool {
    guard let directory = bookmarkDirectoryURL else {
      return false
    }
    let fileURL = directory.appendingPathComponent(name)
    do {
      try fileManager.removeItem(at: fileURL)
      return true
    } catch {
      print(error.localizedDescription)
      return false
    }
  }
  
  func isBookmarkImageExist(withName name: String) -> Bool {
    guard let directory = bookmarkDirectoryURL else {
      return false
    }
    let fileURL = directory.appendingPathComponent("\(name).jpg")
    return fileManager.fileExists(atPath: fileURL.path)
  }

  func getBookmarkImage(with name: String) -> Data? {
    guard let directory = bookmarkDirectoryURL else {
      return nil
    }
    let fileURL = directory.appendingPathComponent("\(name).jpg")
    do {
      let imageData = try Data(contentsOf: fileURL)
      return imageData
    } catch {
      print(error.localizedDescription)
      return nil
    }
  }
}

