//
//  Builder.swift
//  AIImageGeneratorTestApp
//
//  Created by Eugene Kudritsky on 2.05.23.
//

import UIKit

final class Builder: BuilderProtocol {

  static let bookmarkManager = BookmarkManager()

  static func createTabBar() -> UITabBarController {
    let viewModel = TabBarViewModel()
    let view = TabBarViewController(viewModel: viewModel)
    return view
  }

  static func createImageVCModule() -> UIViewController {

    let networkService = NetworkService()
    let imageModel = [ImageModel]()
    let viewModel = GenerateImageViewModel(networkService: networkService, imageModel: imageModel, bookmarksManager: bookmarkManager)
    let view = GenerateImageVC(viewModel: viewModel)

    return view
  }

  static func createBookmarksVCModule() -> UIViewController {
    let imageModel = [ImageModel]()
    let viewModel = BookmarksVCViewModel(imageModel: imageModel, bookmarkManager: bookmarkManager)
    let view = BookmarksVC(viewModel: viewModel)
    return view
  }

}


