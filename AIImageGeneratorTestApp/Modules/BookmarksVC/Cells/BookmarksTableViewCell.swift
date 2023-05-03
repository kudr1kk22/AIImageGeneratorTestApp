//
//  BookmarksTableViewCell.swift
//  AIImageGeneratorTestApp
//
//  Created by Eugene Kudritsky on 3.05.23.
//

import UIKit

final class BookmarksTableViewCell: UITableViewCell {

  //MARK: - Properties

  private let genetaredImageView: UIImageView = {
    let image = UIImageView()
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()

  private let responseImageTextField: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()


  //MARK: - Initialization

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Configure

  func configure(viewModel: BookmarksTableViewCellVM) {
    if let data = viewModel.bookmarkManager.getBookmarkImage(with: viewModel.imageModel.title ?? "") {
      genetaredImageView.image = UIImage(data: data)
    }
    responseImageTextField.text = viewModel.imageModel.title
  }
}

//MARK: - Constraints

extension BookmarksTableViewCell {
  private func setupConstraints() {
    contentView.addSubview(genetaredImageView)
    contentView.addSubview(responseImageTextField)

    NSLayoutConstraint.activate([
      genetaredImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24.0),
      genetaredImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
      genetaredImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24.0),
      genetaredImageView.widthAnchor.constraint(equalTo: genetaredImageView.heightAnchor)
    ])

    NSLayoutConstraint.activate([
      responseImageTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32.0),
      responseImageTextField.leadingAnchor.constraint(equalTo: genetaredImageView.trailingAnchor, constant: 32.0),
      responseImageTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      responseImageTextField.heightAnchor.constraint(equalToConstant: 17.0)
    ])


  }
}

