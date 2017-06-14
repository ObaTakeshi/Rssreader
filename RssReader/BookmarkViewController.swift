//
//  BookmarkViewController.swift
//  RssReader
//
//  Created by oba on 2017/06/06.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class BookmarkViewController: UITableViewController {
    //Objectのサブクラスのみ格納できるArray
    var bookmarks: Results<Bookmark>?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Realmインスタンスの取得
        let realm = try! Realm()
        //ブックマーク全件取得
        bookmarks = realm.objects(Bookmark.self).sorted(byProperty: "date", ascending: false)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkViewCell", for: indexPath)
        guard let bm = bookmarks?[indexPath.row] else {
            return cell
        }
        cell.textLabel?.text = bm.title + " " + bm.detail
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            guard let bm = bookmarks?[indexPath.row] else {
                return
            }
            let item = Item()
            item.link = bm.link
            item.title = bm.title
            item.detail = bm.detail
            
            let controller = segue.destination as! DetailViewController
            controller.item = item
        }
    }
}
