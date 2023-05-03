//
//  BuilderProtocol.swift
//  AIImageGeneratorTestApp
//
//  Created by Eugene Kudritsky on 2.05.23.
//

import UIKit

protocol BuilderProtocol {
  static func createTabBar() -> UITabBarController
  static func createImageVCModule() -> UIViewController
  static func createBookmarksVCModule() -> UIViewController
}
