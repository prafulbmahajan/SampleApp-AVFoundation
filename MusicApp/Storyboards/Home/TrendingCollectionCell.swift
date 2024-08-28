//
//  TrendingCollectionCell.swift
//  MusicApp
//
//  Created by Praful Mahajan on 19/07/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit

class TrendingCollectionCell: UICollectionViewCell {

    @IBOutlet weak var banerImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static func cellIdentifier() -> String {
        return "TrendingCollectionCell"
    }

}
