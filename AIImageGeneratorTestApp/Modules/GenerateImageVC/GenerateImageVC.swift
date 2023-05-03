//
//  GenerateImageVC.swift
//  AIImageGeneratorTestApp
//
//  Created by Eugene Kudritsky on 2.05.23.
//

import UIKit

final class GenerateImageVC: UIViewController {

  //MARK: - Properties

  private let searchTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.borderStyle = .roundedRect
    textField.placeholder = Constants.textFieldPlaceholder
    return textField
  }()

  private lazy var createButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(Constants.buttonTitle, for: .normal)
    button.backgroundColor = .systemBlue
    button.addTarget(self, action: #selector(createImageButtonTapped), for: .touchUpInside)
    return button
  }()

  private lazy var bookmarksButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(Constants.bookmarksButton, for: .normal)
    button.backgroundColor = .systemPink
    button.addTarget(self, action: #selector(addToBookmarksButtonTapped), for: .touchUpInside)
    return button
  }()

  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  var viewModel: GenerateImageViewModelProtocol
  

  //MARK: - Initialization

  init(viewModel: GenerateImageViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setView()
    setConstraints()
  }

  private func setView() {
    view.backgroundColor = .white
    self.title = "Search"
    self.searchTextField.delegate = self
  }

  //MARK: - Actions

  @objc func createImageButtonTapped() {
    viewModel.fetchData(with: searchTextField.text ?? "") { [weak self] result in
      switch result {
      case true:
        DispatchQueue.main.async {
          if let data = self?.viewModel.imageModel.last?.image {
            self?.imageView.image = UIImage(data: data)
          }
        }
      case false:
        self?.showErrorAlert()
      }
    }
  }

  @objc func addToBookmarksButtonTapped() {
    print("Кнопка добавления в закладки")
    guard let model = viewModel.imageModel.last?.image else { return }
    viewModel.saveImage(with: searchTextField.text ?? "", and: model) { [weak self] result in
      switch result {
      case true: self?.showErrorAlert()
      case false: self?.showOkAlert()
      }

    }
  }

  //MARK: - Alert

  private func showErrorAlert() {
      let errorAlert = UIAlertController(title: Constants.error, message: Constants.isExists, preferredStyle: .alert)
      let okButton = UIAlertAction(title: "OK", style: .cancel)
      errorAlert.addAction(okButton)
      present(errorAlert, animated: true)
  }

  private func showOkAlert() {
      let errorAlert = UIAlertController(title: Constants.success, message: Constants.success, preferredStyle: .alert)
    let okButton = UIAlertAction(title: "OK", style: .default)
      errorAlert.addAction(okButton)
      present(errorAlert, animated: true)
  }

}

//MARK: - Constraints

extension GenerateImageVC {
  private func setConstraints() {
    view.addSubview(searchTextField)
    view.addSubview(createButton)
    view.addSubview(imageView)
    view.addSubview(bookmarksButton)

    NSLayoutConstraint.activate([
      imageView.leftAnchor
        .constraint(equalTo: view.leftAnchor, constant: 16.0),
      imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0),
      imageView.bottomAnchor.constraint(equalTo: searchTextField.topAnchor, constant: -8.0),
      imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.85)
    ])

    NSLayoutConstraint.activate([
      searchTextField.leftAnchor
        .constraint(equalTo: view.leftAnchor, constant: 16.0),
      searchTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0),
      searchTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])

    NSLayoutConstraint.activate([
      createButton.leftAnchor
        .constraint(equalTo: view.leftAnchor, constant: 16.0),
      createButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0),
      createButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 8.0)
    ])

    NSLayoutConstraint.activate([
      bookmarksButton.leftAnchor
        .constraint(equalTo: view.leftAnchor, constant: 16.0),
      bookmarksButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0),
      bookmarksButton.topAnchor.constraint(equalTo: createButton.bottomAnchor, constant: 8.0)
    ])
  }
}

//MARK: - TextField delegate

extension GenerateImageVC: UITextFieldDelegate {

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
  }

}


