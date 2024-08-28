//
//  TrendingCell.swift
//  MusicApp
//
//  Created by Praful Mahajan on 19/07/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit

class TrendingCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
            self.collectionView.register(UINib(nibName: TrendingCollectionCell.cellIdentifier(), bundle: nil), forCellWithReuseIdentifier: TrendingCollectionCell.cellIdentifier())
        }
    }
    var callBack : ((Int?)->Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    static func cellIdentifier() -> String {
        return "TrendingCell"
    }

    func cellConfiguration(index: Int) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension TrendingCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCollectionCell.cellIdentifier(), for: indexPath) as! TrendingCollectionCell
        return cell
    }
}

extension TrendingCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.callBack?(indexPath.row)
    }
}
