//
//  DetailCell.swift
//  Swagger
//
//  Created by Patrick on 23.02.2023..
//

import UIKit

/// DetailCell conforms to UITableViewCell with the goal of presenting recieved data in UI within tableView
/// - Parameter keyLabel: UILabel presenting keys recieved from given data
/// - Parameter valueLabel: UILabel presenting values recieved from given data
class DetailCell: UITableViewCell {

    let keyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Supreme-Regular", size: 17)!
        label.textColor = .lightGray
        return label
    }()
    let valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Supreme-Medium", size: 17)!
        label.textColor = UIConstants.textColor
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Method to set up UI
    func setupUI() {
        contentView.backgroundColor = UIConstants.backgroundColor
        contentView.addSubview(keyLabel)
        contentView.addSubview(valueLabel)

        keyLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 50),
            keyLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            keyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.margin),
            valueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.margin)
        ])
    }

    /// Method to set up values in labels
    /// - Parameter viewModel: ``DetailViewModel`` instance containing data recieved from ``UserResponse``
    func setupViewModel(_ viewModel: DetailViewModel) {
        keyLabel.text = "\(viewModel.key):"
        valueLabel.text = viewModel.value
    }
}
