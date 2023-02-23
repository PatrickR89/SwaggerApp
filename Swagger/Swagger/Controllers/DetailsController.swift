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

    func populateDataWith(_ user: UserResponseFiltered) {

        let userMirror = Mirror(reflecting: user)
        for attribute in userMirror.children {

            let valueLabel = "\(attribute.value)"
            let key = getPropertyText(attribute.label!)
            let viewModel = DetailViewModel(key: key, value: valueLabel)
            details.append(viewModel)
        }
    }

    private func getPropertyText(_ key: String) -> String {

        switch key {

        case UserProperties.id.rawValue:
            return "ID"
        case UserProperties.name.rawValue:
            return "Ime"
        case UserProperties.surname.rawValue:
            return "Prezime"
        case UserProperties.fullName.rawValue:
            return "Puno ime"
        case UserProperties.imageId.rawValue:
            return "ID slike"
        case UserProperties.adress.rawValue:
            return "Adresa"
        case UserProperties.phonenumber.rawValue:
            return "Broj mobitela"
        case UserProperties.oib.rawValue:
            return "OIB"
        case UserProperties.email.rawValue:
            return "E-mail"
        case UserProperties.statusId.rawValue:
            return "Status"
        default:
            return ""
        }
    }

    func requestLogout() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(nil, forKey: "AccessToken")
        actions?.controllerDidRequestLogout()
    }
}
