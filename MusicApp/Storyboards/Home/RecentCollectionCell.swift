//
//  RecentCollectionCell.swift
//  MusicApp
//
//  Created by Praful Mahajan on 19/07/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit

class RecentCollectionCell: UICollectionViewCell {

    @IBOutlet weak var banerImage: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static func cellIdentifier() -> String {
        return "RecentCollectionCell"
    }

    func cellConfiguration(index: Int) {
        switch index {
        case 0:
            self.banerImage.image = UIImage(named: "genresImage")
            self.titlelbl.text = "Queen"
            break
        case 1:
            self.banerImage.image = UIImage(named: "radio")
            self.titlelbl.text = "Songs"
            break
        case 2:
            self.banerImage.image = UIImage(named: "woodStock")
            self.titlelbl.text = "Progress"
            break
        case 3:
            self.banerImage.image = UIImage(named: "radio")
            self.titlelbl.text = "Songs"
            break
        case 4:
            self.banerImage.image = UIImage(named: "woodStock")
            self.titlelbl.text = "Progress"
            break
        default:
            break
        }
    }
}
