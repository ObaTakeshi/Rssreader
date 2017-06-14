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
    dynamic var title = ""
    dynamic var detail = ""
    dynamic var link = ""
    dynamic var date: NSDate? = nil
}
