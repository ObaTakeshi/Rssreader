//
//  EditFeedViewController.swift
//  RssReader
//
//  Created by t.ooba on 2017/06/21.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class EditFeedViewController :UIViewController{
    var urlText = ""
    var titleText = ""
    
    @IBOutlet weak var editUrlText: UITextField!
    @IBOutlet weak var editTitleText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editUrlText.placeholder = "URL"
        editTitleText.placeholder = "ページのタイトル"
    }
    
    @IBAction func editFeed(_ sender: Any) {
    
    
        if urlText.text! != "" || titleText.text! != ""{
            let feed = Feed()
            feed.url = urlText.text!
            feed.name = titleText.text!
            feed.date = NSDate()
            
            
            //Realmへの追加
            let realm = try! Realm()
            try! realm.write {
                realm.add(feed)
            }
        
        }
    }
    
}
