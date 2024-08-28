//
//  GenresCollectionCell.swift
//  MusicApp
//
//  Created by Praful Mahajan on 19/07/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit

class GenresCollectionCell: UICollectionViewCell {

    @IBOutlet weak var banerImage: UIImageView!
    @IBOutlet weak var banerTitle: UILabel!
    @IBOutlet weak var titleXConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleYConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static func cellIdentifier() -> String {
        return "GenresCollectionCell"
    }

    func cellGenresConfiguration(index: Int) {
        self.banerImage.image = UIImage(named: "bg2")
        self.titleXConstraint.constant = 20.0
        self.titleYConstraint.constant = 12.0
        switch index {
        case 0:
            self.banerTitle.textAlignment = .left
            self.banerTitle.text = "HIP-HOP"
            break
        case 1:
            self.banerTitle.textAlignment = .left
            self.banerTitle.text = "POP"
            break
        case 2:
            self.banerTitle.textAlignment = .left
            self.banerTitle.text = "HYPHY"
            break
        case 3:
            self.banerTitle.textAlignment = .left
            self.banerTitle.text = "JAZZ RAP"
            break
        case 4:
            self.banerTitle.textAlignment = .left
            self.banerTitle.text = "LATIN JAZZ"
            break
        default:
            break
        }
    }

    func cellMoodsConfiguration(index: Int) {
        self.banerImage.image = UIImage(named: "bg1")
        self.titleXConstraint.constant = 0.0
        self.titleYConstraint.constant = 0.0
        switch index {
        case 0:
            self.banerTitle.text = "PARTY"
            break
        case 1:
            self.banerTitle.text = "CHILL"
            break
        case 2:
            self.banerTitle.text = "FRANTIC"
            break
        case 3:
            self.banerTitle.text = "ENERGETIC"
            break
        case 4:
            self.banerTitle.text = "ANXIOUS/SAD"
            break
        default:
            break
        }
    }
}
