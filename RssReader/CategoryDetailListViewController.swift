//
//  CategoryDetailListViewController.swift
//  RssReader
//
//  Created by oba on 2017/06/14.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import Foundation
import UIKit

class CategoryDetailListViewController : UITableViewController{
    var categoryText:String = ""
    var url:String = ""
    var xml: LivtViewXmlParser?
    
    
    //画面が表示された直後
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        xml = LivtViewXmlParser()
        if categoryText != ""{
            self.title = categoryText
            xml?.setCategolyText(text: categoryText)
            xml?.parse(url: url) {
                self.tableView.reloadData()
            }
        }
    }
    
    //セルのタップ時に送るデータ
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let x = xml else {
            return
        }
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let controller = segue.destination as! DetailViewController
            controller.item = x.items[indexPath.row]
        }
    }
    
    //必須メソッド(戻り値はセルの数)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //nilか否か
        return xml?.items.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryDetailCell", for: indexPath)
        guard let x = xml?.items[indexPath.row] else {
            return cell
        }
        cell.textLabel?.text = x.title
        return cell
    }
}

