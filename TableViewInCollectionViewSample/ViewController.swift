//
//  ViewController.swift
//  TableViewInCollectionViewSample
//
//  Created by satoshi.marumoto on 2020/01/31.
//  Copyright © 2020 satoshi.marumoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var park = [["title": "丸亀製麺",
                 "money": "時給5000円",
                 "place": "不動前",
                 "imageName" : "park"],
                ["title": "マクドナルド",
                "money": "時給999円",
                "place": "目黒",
                "imageName" : "park"],
                ["title": "漫画喫茶",
                 "money": "時給999円",
                 "place": "五反田",
                 "imageName" : "park"],
                ["title": "Hub",
                 "money": "時給4999円",
                 "place": "五反田",
                 "imageName" : "park"],
                ["title": "ミート矢澤",
                 "money": "時給4999円",
                 "place": "五反田",
                 "imageName" : "park"]]
    
    var sun = [["imageName" : "sun"],
               ["imageName" : "sun"],
               ["imageName" : "sun"],
               ["imageName" : "sun"],
               ["imageName" : "sun"]]
    
    var wave = [["imageName" : "wave"],
                ["imageName" : "wave"],
                ["imageName" : "wave"],
                ["imageName" : "wave"],
                ["imageName" : "wave"]]
    
    var road = [["imageName" : "road"],
                ["imageName" : "road"],
                ["imageName" : "road"],
                ["imageName" : "road"],
                ["imageName" : "road"]]
    
    var flower = [["imageName" : "flower"],
                  ["imageName" : "flower"],
                  ["imageName" : "flower"],
                  ["imageName" : "flower"],
                  ["imageName" : "flower"]]

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
        tableView.rowHeight = 230
    }
}

extension ViewController:  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 240, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell2", for: indexPath) as? CollectionViewCell else {fatalError()}

        switch (collectionView.tag) {
        case 0:
            cell.imageView.image = UIImage(named: park[indexPath.row]["imageName"]!)
            cell.titleLabel.text = park[indexPath.row]["title"]
            cell.moneyLabel.text = park[indexPath.row]["money"]
            cell.placeLabel.text = park[indexPath.row]["place"]

        case 1:
            cell.imageView.image = UIImage(named: sun[indexPath.row]["imageName"]!)
        case 2:
            cell.imageView.image = UIImage(named: wave[indexPath.row]["imageName"]!)
        
        case 3:
            cell.imageView.image = UIImage(named: road[indexPath.row]["imageName"]!)
            
        case 4:
            cell.imageView.image = UIImage(named: flower[indexPath.row]["imageName"]!)

        default:
            print("section error")
        }
        return cell
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {

    //セクション数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell2", for: indexPath) as? TableViewCell else {fatalError()}

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

