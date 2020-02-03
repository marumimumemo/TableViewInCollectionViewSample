//
//  ViewController.swift
//  TableViewInCollectionViewSample
//
//  Created by satoshi.marumoto on 2020/01/31.
//  Copyright © 2020 satoshi.marumoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var recommend = [["title": "公園設営",
                 "money": "時給5000円",
                 "place": "不動前",
                 "imageName" : "park"],
                ["title": "道路工事",
                "money": "時給999円",
                "place": "目黒",
                "imageName" : "road"],
                ["title": "生花講師",
                 "money": "時給999円",
                 "place": "五反田",
                 "imageName" : "flower"],
                ["title": "リゾートバイト",
                 "money": "時給4999円",
                 "place": "五反田",
                 "imageName" : "sun"],
                ["title": "海の家",
                 "money": "時給4999円",
                 "place": "五反田",
                 "imageName" : "wave"]]

    var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = UITableView(frame: view.frame, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        self.tableView = tableView

        //カスタムセル登録
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "tableViewCell2")

        //tableViewの使わないセルの区切り線を消す
        tableView.tableFooterView = UIView()

        //tableViewの高さ指定
        tableView.rowHeight = 150
    }
}

extension ViewController:  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell2", for: indexPath) as? CollectionViewCell else {fatalError()}

        switch (collectionView.tag) {
        case 0:
            cell.imageView.image = UIImage(named: recommend[indexPath.row]["imageName"]!)
            cell.titleLabel.text = recommend[indexPath.row]["title"]
            cell.moneyLabel.text = recommend[indexPath.row]["money"]
            cell.placeLabel.text = recommend[indexPath.row]["place"]

        default:
            print("section error")
        }
        return cell
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {

    enum Section: Int {
        case recommend = 0
        case normal
    }
    //セクション数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    //セクション内のセル数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
        case .recommend?:
            return 1
        case .normal?:
            return 5
        case .none:
            return 0
        }
        
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? TableViewCell else { return }

        //TableViewCell.swiftで設定したメソッドを呼び出す(indexPath.section)
        cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.section)
    }

    //セルの内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell2", for: indexPath) as? TableViewCell else {fatalError()}
            
            //TableViewCell.swiftで設定したメソッドを呼び出す(indexPath.row)
            cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
            cell.collectionView.reloadData()
            return cell
        }
        return UITableViewCell()
    }

    //セルが選択された時の対処
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
