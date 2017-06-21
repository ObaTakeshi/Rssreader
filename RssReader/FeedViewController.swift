//
//  FeedViewController.swift
//  RssReader
//
//  Created by oba on 2017/06/13.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class FeedViewController: UITableViewController {
    var feeds: Results<Feed>?
   // let objects = ["はてなブックマーク","NHK"]
    
    @IBAction func backTo(segue:UIStoryboardSegue){
        tableView.reloadData()

    }
    //画面が表示された直後
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationItem.leftBarButtonItem = editButtonItem
        //Realmインスタンスの取得
        let realm = try! Realm()
        //ブックマーク全件取得
        feeds = realm.objects(Feed.self).sorted(byProperty: "date", ascending: false)
        
        tableView.reloadData()
    }
    
//    override func setEditing(_ editing: Bool, animated: Bool) {
//        super.setEditing(editing,animated:animated)
//        //self.tableView.allowsSelectionDuringEditing = true
//        //tableView.setEditing(editing, animated:animated)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let controller = segue.destination as! ListViewController
            controller.url = (feeds?[indexPath.row].url)!
            controller.name = (feeds?[indexPath.row].name)!
        }
    }
    
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if(editingStyle == UITableViewCellEditingStyle.delete) {
//            do{
//                let realm = try Realm()
//                try realm.write {
//                    realm.delete((feeds?[indexPath.row])!)
//                }
//                tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
//            }catch{
//            }
//            tableView.reloadData()
//        }
//    }
    
    //必須メソッド(戻り値はセルの数)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //nilか否か
        //return objects.count
        return feeds?.count ?? 0
    }
    
    //必須メソッド(戻り値はセルの内容)　indexPathは現在設定しているセルの行番号を保持
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //dequeue~Cellはセルの再利用(引数に再利用するセル(ストーリボードのIdentifer))
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath)
        guard let fe = feeds?[indexPath.row] else {
            return cell
        }
        cell.textLabel?.text = fe.name
        
        return cell
    }
}
