//
//  BookmarksVC.swift
//  AIImageGeneratorTestApp
//
//  Created by Eugene Kudritsky on 3.05.23.
//

import UIKit

final class BookmarksVC: UIViewController {
  //MARK: - Properties

  private var tableView: UITableView = UITableView(frame: .zero)
  var viewModel: BookmarksVCViewModelProtocol

  //MARK: - Initialization

  init(viewModel: BookmarksVCViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Life Cycle

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(false)
    tableView.reloadData()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Bookmarks"
    setupTableView()
    registerCells()
    setConstraints()
  }

  //MARK: - Setup TableView

  private func setupTableView() {
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.showsVerticalScrollIndicator = false
    tableView.rowHeight = 120.0
  }

  private func registerCells() {
    tableView.register(BookmarksTableViewCell.self, forCellReuseIdentifier: String(describing: BookmarksTableViewCell.self))
  }

}

//MARK: - UITableViewDataSource

extension BookmarksVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.imageModel.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BookmarksTableViewCell.self), for: indexPath) as? BookmarksTableViewCell else {
      return UITableViewCell()
    }
    let bookmarkManager = BookmarkManager()
    let imageModel = viewModel.imageModel[indexPath.row]
    let viewModelCell = BookmarksTableViewCellVM(bookmarkManager: bookmarkManager, imageModel: imageModel)

    cell.configure(viewModel: viewModelCell)
    return cell
  }
}

//MARK: - UITableViewDelegate

extension BookmarksVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

//MARK: - Constraints

extension BookmarksVC {
  private func setConstraints() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}

