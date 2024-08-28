//
//  AccountTxtCell.swift
//  MusicApp
//
//  Created by Praful Mahajan on 05/08/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit
import DTTextField

class AccountTxtCell: UITableViewCell {
    static let ID = "AccountTxtCell"

    @IBOutlet weak var txtField: DTTextField! {
        didSet {
            self.txtField.placeholderColor = .white
            self.txtField.dtborderStyle = .none
            //self.txtField.dtLayer.backgroundColor = UIColor.init(hexString: "#222222").cgColor
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func cellConfiguration(row: Int) {
        switch row {
        case 0:
            self.txtField.placeholder = "First Name"
            self.txtField.text = "John"
            break
        case 1:
            self.txtField.placeholder = "Last Name"
            self.txtField.text = "Doe"
            break
        case 2:
            self.txtField.placeholder = "Gender"
            self.txtField.text = "Male"
            break
        case 3:
            self.txtField.placeholder = "Date of Birth"
            self.txtField.text = "01.01.1990"
            break
        case 4:
            self.txtField.placeholder = "Email"
            self.txtField.text = "randomexample@gmail.com"
            break
        case 5:
            self.txtField.placeholder = "Country"
            self.txtField.text = "Ukraine"
            break
        default:
            break
        }
    }
    
}
