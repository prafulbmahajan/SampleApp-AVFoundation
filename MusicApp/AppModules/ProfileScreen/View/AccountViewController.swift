//
//  AccountViewController.swift
//  MusicApp
//
//  Created by Praful Mahajan on 05/08/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.separatorStyle = .none
            self.tableView.register(UINib(nibName: AccountHeaderView.ID, bundle: nil), forHeaderFooterViewReuseIdentifier: AccountHeaderView.ID)
            self.tableView.register(UINib(nibName: AccountTxtCell.ID, bundle: nil), forCellReuseIdentifier: AccountTxtCell.ID)
            self.tableView.register(UINib(nibName: AccountLblCell.ID, bundle: nil), forCellReuseIdentifier: AccountLblCell.ID)
        }
    }

    @IBOutlet weak var subscribeDetail: UIButton! {
        didSet {
            self.subscribeDetail.setTitle("GO TO PLUS (+)", for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let authToken = LocalStore.getAuthToken()
        if authToken.count > 0 {
            self.subscribeDetail.setTitle("Subscription Detail", for: .normal)
        }
    }

    @IBAction func logoutButtonDidClicked(_ sender: Any) {
        let accountViewModel = AccountViewModel()
        accountViewModel.callLogoutAPI { (response, message) in }
        let vc = Generic.getNavigationControllerFromStoryBoard(container: .LoginContainer, storyBoard: .MAIN)
        LocalStore.setAuthToken(authToken: "")
        LocalStore.setSelectedSegment(segment: 0)
        AppDelegate.sharedInstance.window?.rootViewController = vc
    }

    @IBAction func goPremiumButtonDidClicked(_ sender: Any) {
        if let vc = Generic.getViewControllerFromStoryBoard(type: SubscriptionViewController.self, storyBoard: .PROFILE) {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension AccountViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 6
        case 1:
            return 1
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            let row = indexPath.row
            let cell = tableView.dequeueReusableCell(withIdentifier: AccountTxtCell.ID, for: indexPath) as! AccountTxtCell
            cell.selectionStyle = .none
            cell.cellConfiguration(row: row)
            return cell
        case 1:
            let row = indexPath.row
            let cell = tableView.dequeueReusableCell(withIdentifier: AccountLblCell.ID, for: indexPath) as! AccountLblCell
            cell.selectionStyle = .none
            cell.lblText.text = "Change password"
            return cell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: AccountHeaderView.ID) as! AccountHeaderView
        switch section {
        case 0:
            headerView.banerHeaderTitle.text = "Contact"
            headerView.backgroundColor = .black
            return headerView
        case 1:
            headerView.banerHeaderTitle.text = "Account"
            headerView.backgroundColor = .black
            return headerView
        default:
            return nil
        }
    }
}

extension AccountViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 54.0
    }
}
