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
    
    @IBOutlet weak var urlText: UITextField!
    @IBOutlet weak var titleText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func registerButton(_ sender: AnyObject) {
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