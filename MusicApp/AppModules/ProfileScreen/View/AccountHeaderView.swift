//
//  AccountHeaderView.swift
//  MusicApp
//
//  Created by Praful Mahajan on 05/08/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit

class AccountHeaderView: UITableViewHeaderFooterView {
    static let ID = "AccountHeaderView"

    //**************************************************
    // MARK: - IBOutlets
    //**************************************************
    @IBOutlet weak var banerHeaderTitle:UILabel!

    //**************************************************
    // MARK: - Required Methods
    //**************************************************
    override func draw(_ rect: CGRect) {

    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }


}
