//
//  DetailCell.swift
//  Swagger
//
//  Created by Patrick on 23.02.2023..
//

import UIKit

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

    func setupViewModel(_ viewModel: DetailViewModel) {
        keyLabel.text = "\(viewModel.key):"
        valueLabel.text = viewModel.value
    }
}
