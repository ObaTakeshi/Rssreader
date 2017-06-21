//
//  AddFeedViewController.swift
//  RssReader
//
//  Created by oba on 2017/06/13.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class AddFeedViewController :UIViewController{

    var editUrl = ""
    var editTitle = ""
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var urlText: UITextField!
    @IBOutlet weak var titleText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        urlText.placeholder = "URL"
        urlText.text = editUrl
        titleText.placeholder = "ページのタイトル"
        titleText.text = editTitle
        
        if editUrl == "" && editTitle == ""{
            sendButton.setTitle("Add Feed", for: .normal)
        }else{
            sendButton.setTitle("Edit Complete",for: .normal)
        }
    }
    
    @IBAction func registerButton(_ sender: AnyObject) {
        if urlText.text! != "" || titleText.text! != ""{
            let feed = Feed()
            feed.url = urlText.text!
            feed.name = titleText.text!
            feed.date = NSDate()
            if editUrl == "" && editTitle == ""{
                //Realmへの追加
                let realm = try! Realm()
                try! realm.write {
                    realm.add(feed)
                }
            }else{
                //Realmの編集
                let realm = try! Realm()
                let result = realm.objects(Feed.self).filter("url == %@ && name == %@",editUrl,editTitle).first
                try! realm.write{
                    if urlText.text != result?.url{
                        result?.url = urlText.text!
                    }
                    if titleText.text != result?.name{
                        result?.name = titleText.text!
                    }
                }
            }
        }
    }
}
