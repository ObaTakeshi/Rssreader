//
//  DetailViewController.swift
//  RssReader
//
//  Created by oba on 2017/06/06.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let i = item else {
            return
        }
        
        if let url = URL(string: i.link) {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
    }
    @IBAction func addBookmark(_ sender: AnyObject) {
    
        guard let i = item else {
            return
        }
        
        //ブックマークインスタンスの作成
        let bookmark = Bookmark()
        bookmark.title = i.title
        bookmark.detail = i.detail
        bookmark.link = i.link
        bookmark.date = NSDate()
        
        //Realmへの追加
        let realm = try! Realm()
        try! realm.write {
            realm.add(bookmark)
        }
        
    }
}

