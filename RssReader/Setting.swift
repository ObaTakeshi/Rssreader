//
//  Setting.swift
//  RssReader
//
//  Created by oba on 2017/06/06.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import Foundation
import RealmSwift

enum Setting {
    static let RssUrl = "http://feeds.feedburner.com/hatena/b/hotentry"
    static let RssUrl1 = "http://www3.nhk.or.jp/rss/news/cat0.xml"
}

class Feed: Object {
    dynamic var name = ""
    dynamic var url = ""
    dynamic var date: NSDate? = nil
}
