//
//  Bookmark.swift
//  RssReader
//
//  Created by oba on 2017/06/06.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import Foundation
import RealmSwift

//Realmのテーブル
class Bookmark: Object {
    @objc dynamic var title = ""
    @objc dynamic var detail = ""
    @objc dynamic var link = ""
    @objc dynamic var date: NSDate? = nil
}
