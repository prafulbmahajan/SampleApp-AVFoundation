//
//  AddTrackCell.swift
//  MusicApp
//
//  Created by Praful Mahajan on 16/08/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit

class AddTrackCell: UITableViewCell {
    static let ID = "AddTrackCell"

    @IBOutlet weak var addOptionTitle: UILabel!
    @IBOutlet weak var addOptionIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func cellConfiguration(addOption: AddOptions) {
        self.addOptionTitle.text = addOption.addTitle
        self.addOptionIcon.image = UIImage(named: addOption.addIcon)
    }    
}
