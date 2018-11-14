//
//  Event.swift
//  calender_app
//
//  Created by Ryusei Wada on 2018/11/12.
//  Copyright © 2018年 Ryusei Wada. All rights reserved.
//

import Foundation
import RealmSwift

class Event: Object{
    @objc dynamic var date: String = ""
    @objc dynamic var event: String = ""
    @objc dynamic var id: String = "0"
    
    // プライマリーキーの設定
    override static func primaryKey() -> String? {
        return "id"
    }
}
