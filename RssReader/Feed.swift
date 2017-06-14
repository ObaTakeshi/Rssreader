//
//  Setting.swift
//  RssReader
//
//  Created by oba on 2017/06/06.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import Foundation
import RealmSwift

class Feed: Object {
    dynamic var name = ""
    dynamic var url = ""
    dynamic var date: NSDate? = nil
}
