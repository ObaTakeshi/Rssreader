//
//  CategolyViewController.swift
//  RssReader
//
//  Created by oba on 2017/06/07.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import Foundation
import UIKit

class CategolyViewController: UITableViewController {
    var dataList = ["トピック","ヘッドライン","エリアガイド","総合","一般","世の中","政治と経済","暮らし","学び","テクノロジー","エンタメ","アニメとゲーム","おもしろ","動画","画像","ランキング","おすすめ"]
    func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CategolyViewCell", for:indexPath) as? UITableViewCell
        cell.textLabel?.text = dataList[indexPath.row]
        return cell
    }
    
    //データの個数を返すメソッド
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        return dataList.count
    }
    
    //最初からあるメソッド
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
class CategolyViewCell: UITableViewCell {
    @IBOutlet weak var categoly: UIView!
    
    var item: Item? {
        didSet {
            categoly.text = 
        }
    }
}
