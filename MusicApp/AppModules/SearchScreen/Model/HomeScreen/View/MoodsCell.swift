//
//  MoodsCell.swift
//  MusicApp
//
//  Created by Praful Mahajan on 19/07/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit

class MoodsCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
            self.collectionView.register(UINib(nibName: GenresCollectionCell.cellIdentifier(), bundle: nil), forCellWithReuseIdentifier: GenresCollectionCell.cellIdentifier())
        }
    }

    var callBack : ((Int?)->Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    static func cellIdentifier() -> String {
        return "MoodsCell"
    }

    func cellConfiguration(index: Int) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension MoodsCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenresCollectionCell.cellIdentifier(), for: indexPath) as! GenresCollectionCell
        cell.cellMoodsConfiguration(index: indexPath.row)
        return cell
    }
}

extension MoodsCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.callBack?(indexPath.row)
    }
}
