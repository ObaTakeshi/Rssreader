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
    @objc dynamic var name = ""
    @objc dynamic var url = ""
    @objc dynamic var date: NSDate? = nil
}
