//
//  CollectionViewCell.swift
//  TableViewInCollectionViewSample
//
//  Created by satoshi.marumoto on 2020/01/31.
//  Copyright © 2020 satoshi.marumoto. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
