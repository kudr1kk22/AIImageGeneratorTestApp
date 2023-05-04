//
//  TabBarViewController.swift
//  AIImageGeneratorTestApp
//
//  Created by Eugene Kudritsky on 2.05.23.
//

import UIKit

final class TabBarViewController: UITabBarController {

  //MARK: - Properties

  private let viewModel: TabBarViewModelProtocol

  //MARK: - Initialization

  init(viewModel: TabBarViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.setViewControllers(viewModel.createTabBarItems())
//    self.delegate = self
  }
}

////MARK: - Tabbar delegate
//
//extension TabBarViewController: UITabBarControllerDelegate {
//  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//    guard let navController = viewController as? UINavigationController, let bookmarkVC = navController.viewControllers.first as? BookmarksVC else {
//      return }
//    bookmarkVC.viewModel.imageModel = bookmarkVC.viewModel.fetchFromCoreData()
//    }
//}

// MARK: - TabBarViewProtocol

extension TabBarViewController: TabBarViewProtocol {
  func setViewControllers(_ viewControllers: [UIViewController]) {
    setViewControllers(viewControllers, animated: false)
  }
}
