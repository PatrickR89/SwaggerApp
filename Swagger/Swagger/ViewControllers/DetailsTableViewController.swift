//
//  DetailsTableViewController.swift
//  Swagger
//
//  Created by Patrick on 23.02.2023..
//

import UIKit

class DetailsTableViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIConstants.buttonColor
        button.setTitleColor(UIConstants.backgroundColor, for: .normal)
        button.layer.cornerRadius = UIConstants.elementHeight / 2
        button.titleLabel?.font = UIFont(name: "Supreme-Bold", size: 17)!
        button.setTitle("LOG OUT", for: .normal)
        return button
    }()

    let controller: DetailsController

    init(_ controller: DetailsController) {
        self.controller = controller
        super.init(nibName: nil, bundle: nil)
        controller.setupDataSource(for: tableView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        view.backgroundColor = UIConstants.backgroundColor
        tableView.backgroundColor = UIConstants.backgroundColor
        addButton()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DetailCell.self, forCellReuseIdentifier: "Detail cell")
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: logoutButton.topAnchor, constant: -UIConstants.margin),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func addButton() {
        view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)

        NSLayoutConstraint.activate([
            logoutButton.heightAnchor.constraint(equalToConstant: UIConstants.elementHeight),
            logoutButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            logoutButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -UIConstants.margin),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc func logout() {
        controller.requestLogout()
    }
}
