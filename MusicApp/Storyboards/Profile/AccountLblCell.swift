//
//  AccountLblCell.swift
//  MusicApp
//
//  Created by Praful Mahajan on 05/08/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit

class AccountLblCell: UITableViewCell {
    static let ID = "AccountLblCell"

    @IBOutlet weak var lblText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear//UIColor.init(hexString: "#222222")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
