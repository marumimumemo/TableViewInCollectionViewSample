//
//  TableViewCell.swift
//  TableViewInCollectionViewSample
//
//  Created by satoshi.marumoto on 2020/01/31.
//  Copyright © 2020 satoshi.marumoto. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // カスタムセルの登録
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "collectionViewCell2")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setCollectionViewDataSourceDelegate
        <D: UICollectionViewDataSource & UICollectionViewDelegate>
        (dataSourceDelegate: D, forRow row: Int) {

        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.reloadData()
    }
}
