//
//  TabBarViewModel.swift
//  AIImageGeneratorTestApp
//
//  Created by Eugene Kudritsky on 2.05.23.
//

import UIKit

final class TabBarViewModel {

}

// MARK: - TabBarProtocol

extension TabBarViewModel: TabBarViewModelProtocol {
  

  func createTabBarItems() -> [UIViewController] {
    let generateImageVC = Builder.createImageVCModule()
    let bookmarksVC = Builder.createBookmarksVCModule()
    
    generateImageVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
    bookmarksVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)

    let generateImageVCnavigationController = UINavigationController(rootViewController: generateImageVC)

    let bookmarksVCnavigationController = UINavigationController(rootViewController: bookmarksVC)


    let viewControllers = [
      generateImageVCnavigationController,
      bookmarksVCnavigationController]

    return viewControllers
  }
}
