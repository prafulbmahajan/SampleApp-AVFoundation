//
//  HeaderView.swift
//  MusicApp
//
//  Created by Praful Mahajan on 19/07/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {

    //**************************************************
    // MARK: - IBOutlets
    //**************************************************
    @IBOutlet weak var banerHeaderTitle:UILabel!
    @IBOutlet weak var subTitle:UILabel!
    @IBOutlet weak var viewAll:UIView!
    @IBOutlet weak var seeAllAction:ActionButton!
    @IBOutlet weak var centerConstraint:NSLayoutConstraint!

    //**************************************************
    // MARK: - Constants
    //**************************************************
    enum Constant {
        static let Identifier = "HeaderView"
    }

    //**************************************************
    // MARK: - Required Methods
    //**************************************************
    override func draw(_ rect: CGRect) {

    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    //**************************************************
    // MARK: - Identifier Methods
    //**************************************************
    static func cellIdentifier() -> String {
        return Constant.Identifier
    }

    func cellConfiguration(index: Int) {
        switch index {
        case 0:
            self.centerConstraint.constant = 0
            self.banerHeaderTitle.text = "Trending"
            self.subTitle.text = ""
            self.viewAll.isHidden = true
            break
        case 1:
            self.centerConstraint.constant = 0
            self.banerHeaderTitle.text = "Recently played"
            self.subTitle.text = ""
            self.viewAll.isHidden = true
            break
        case 2:
            self.centerConstraint.constant = -9
            self.banerHeaderTitle.text = "Genres"
            self.subTitle.text = "Explore by genre"
            self.viewAll.isHidden = false
            break
        case 3:
            self.centerConstraint.constant = -9
            self.banerHeaderTitle.text = "Moods"
            self.subTitle.text = "Explore by Moods"
            self.viewAll.isHidden = false
            break
        case 4:
            self.centerConstraint.constant = 0
            self.banerHeaderTitle.text = "Most Playing Tracks"
            self.subTitle.text = ""
            self.viewAll.isHidden = true
            break
        default:
            break
        }
    }

}
