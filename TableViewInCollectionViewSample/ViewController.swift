//
//  ViewController.swift
//  TableViewInCollectionViewSample
//
//  Created by satoshi.marumoto on 2020/01/31.
//  Copyright © 2020 satoshi.marumoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var park = [["name" : "park",
                 "imageName" : "park"],
                ["name" : "park",
                 "imageName" : "park"],
                ["name" : "park",
                 "imageName" : "park"]]
    var sun = [["name" : "sun",
                  "imageName" : "sun"],
                 ["name" : "sun",
                  "imageName" : "sun"],
                 ["name" : "sun",
                  "imageName" : "sun"]]
    var wave = [["name" : "wave",
                  "imageName" : "wave"],
                 ["name" : "wave",
                  "imageName" : "wave"],
                 ["name" : "wave",
                  "imageName" : "wave"]]

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //ファイル内処理
        tableView.dataSource = self
        tableView.delegate = self

        //カスタムセル登録
        let nib = UINib(nibName: "tableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "tableViewCell2")

        //tableViewの使わないセルの区切り線を消す
        tableView.tableFooterView = UIView()

        //tableViewの高さ指定
        tableView.rowHeight = 200
    }
}

extension ViewController:  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 240, height: 180)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell2", for: indexPath) as! CollectionViewCell

        switch (collectionView.tag) {
        case 0:
            cell.imageView.image = UIImage(named: park[indexPath.row]["imageName"]!)
            cell.textLabel.text = park[indexPath.row]["name"]

        case 1:
            cell.imageView.image = UIImage(named: sun[indexPath.row]["imageName"]!)
            cell.textLabel.text = sun[indexPath.row]["name"]

        case 2:
            cell.imageView.image = UIImage(named: wave[indexPath.row]["imageName"]!)
            cell.textLabel.text = wave[indexPath.row]["name"]

        default:
            print("section error")
        }
        return cell
    }
}


extension ViewController:   UITableViewDataSource, UITableViewDelegate {

    //セクション数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    //セクション内のセル数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? TableViewCell else { return }

        //TableViewCell.swiftで設定したメソッドを呼び出す(indexPath.section)
        cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.section)
    }

    //セルの内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell2", for: indexPath) as! TableViewCell

        //TableViewCell.swiftで設定したメソッドを呼び出す(indexPath.row)
        cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
        cell.collectionView.reloadData()
        return cell
    }

    //セルが選択された時の対処
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "section\(section + 1)"
    }

}

