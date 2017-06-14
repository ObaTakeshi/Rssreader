//
//  ListViewController.swift
//  RssReader
//
//  Created by oba on 2017/06/06.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage


class ListViewController: UITableViewController {
    var url:String = ""
    var xml: LivtViewXmlParser?
    
    //画面が表示された直後
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        xml = LivtViewXmlParser()
        //URLの指定
        xml?.parse(url: url) {
            self.tableView.reloadData()
        }
    }
    
    //セルのタップ時に送るデータ
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Category"{
            let controller = segue.destination as! CategoryViewController
            controller.url = url
        }else{
            guard let x = xml else {
                return
            }
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! DetailViewController
                controller.item = x.items[indexPath.row]
            }
        }
    }
    
    //必須メソッド(戻り値はセルの数)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //nilか否か
        return xml?.items.count ?? 0
    }
    
    //必須メソッド(戻り値はセルの内容)　indexPathは現在設定しているセルの行番号を保持
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //dequeue~Cellはセルの再利用(引数に再利用するセル(ストーリボードのIdentifer))
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListViewCell", for: indexPath) as? ListViewCell else {
            fatalError("Invalid cell")
        }
        
        guard let x = xml else {
            return cell
        }
        
        cell.item = x.items[indexPath.row]
        
        return cell
    }
}

class ListViewCell: UITableViewCell {
    //宣言の際クラス名に!をつけることで以後プロパティ名の使用に!を用いなくていい
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var imageLabel: UIImageView!
    
    var item: Item? {
        didSet {
            titleLabel.text = item?.title
            descriptionLabel.numberOfLines = 4
            descriptionLabel.text = item?.detail
            imageLabel.sd_setImage(with: NSURL(string: (item?.image)!) as URL?, placeholderImage: UIImage(named: "noImage.png"))
        }
    }
}



