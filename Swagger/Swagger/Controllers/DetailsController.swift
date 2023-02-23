//
//  DetailsController.swift
//  Swagger
//
//  Created by Patrick on 23.02.2023..
//

import UIKit
import Combine

protocol DetailsControllerActions: AnyObject {
    func controllerDidRequestLogout()
}

class DetailsController {

    private(set) var diffableDataSource: UITableViewDiffableDataSource<Int, String>?
    // details published for test purpose
    @Published private(set) var details = [DetailViewModel]() {
        didSet {
            updateSnapshot()
        }
    }

    weak var actions: DetailsControllerActions?

    func setupDataSource(for tableView: UITableView) {
        let diffableDataSource = UITableViewDiffableDataSource
        <Int, String>(tableView: tableView) { [weak self] tableView, indexPath, itemIdentifier in

            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "Detail cell",
                for: indexPath) as? DetailCell else {
                fatalError("Cell not found")
            }

            if let detail = self?.details.first(where: {$0.key == itemIdentifier}) {
                cell.setupViewModel(detail)
            }

            return cell
        }

        self.diffableDataSource = diffableDataSource
        updateSnapshot()
    }

    private func updateSnapshot() {
        guard let diffableDataSource = diffableDataSource else {
            return
        }

        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])

        for detail in details {
            snapshot.appendItems([detail.key], toSection: 0)
        }
        diffableDataSource.apply(snapshot)
    }

    func populateDataWith(_ user: UserResponse) {

        details = [
            DetailViewModel(key: "ID", value: "\(user.id)"),
            DetailViewModel(key: "Ime", value: user.name ?? "Nepoznato"),
            DetailViewModel(key: "Prezime", value: user.surname ?? "Nepoznato"),
            DetailViewModel(key: "Puno ime", value: user.fullName ?? "Nepoznato"),
            DetailViewModel(key: "ID slike", value: user.imageId == nil ? "Nepoznato" : "\(user.imageId!)"),
            DetailViewModel(key: "Adresa", value: user.adress ?? "Nepoznato"),
            DetailViewModel(key: "Broj mobitela", value: user.phonenumber ?? "Nepoznato"),
            DetailViewModel(key: "OIB", value: user.oib ?? "Nepoznato"),
            DetailViewModel(key: "E-mail", value: user.email ?? "Nepoznato"),
            DetailViewModel(key: "Status", value: "\(user.statusId)")
        ]
    }

    func requestLogout() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(nil, forKey: "AccessToken")
        actions?.controllerDidRequestLogout()
    }
}
