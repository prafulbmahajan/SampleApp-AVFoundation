//
//  RecentlyPlayedCell.swift
//  MusicApp
//
//  Created by Praful Mahajan on 19/07/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit

class RecentlyPlayedCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
            self.collectionView.register(UINib(nibName: RecentCollectionCell.cellIdentifier(), bundle: nil), forCellWithReuseIdentifier: RecentCollectionCell.cellIdentifier())
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    static func cellIdentifier() -> String {
        return "RecentlyPlayedCell"
    }

    func cellConfiguration(index: Int) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension RecentlyPlayedCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentCollectionCell.cellIdentifier(), for: indexPath) as! RecentCollectionCell
        cell.cellConfiguration(index: indexPath.row)
        return cell
    }
}

extension RecentlyPlayedCell: UICollectionViewDelegate {

}
