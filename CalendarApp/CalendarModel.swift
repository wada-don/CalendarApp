//
//  CalendarSetting.swift
//  CalendarApp
//
//  Created by Ryusei Wada on 2018/11/12.
//  Copyright © 2018年 Ryusei Wada. All rights reserved.
//

import Foundation
import CalculateCalendarLogic
import FSCalendar
import RealmSwift


class CalendarModel{
    
    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    // 祝日判定を行い結果を返すメソッド(True:祝日)
    func judgeHoliday(_ date : Date) -> Bool {
        //祝日判定用のカレンダークラスのインスタンス
        let tmpCalendar = Calendar(identifier: .gregorian)
        
        // 祝日判定を行う日にちの年、月、日を取得
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        
        // CalculateCalendarLogic()：祝日判定のインスタンスの生成
        let holiday = CalculateCalendarLogic()
        
        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }
    // date型 -> 年月日をStringで取得
    func getDay(_ date:Date) -> String{
        let tmpCalendar = Calendar(identifier: .gregorian)
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        return "\(year)/\(month)/\(day)"
    }
    
    //曜日判定(日曜日:1 〜 土曜日:7)
    func getWeekIdx(_ date: Date) -> Int{
        let tmpCalendar = Calendar(identifier: .gregorian)
        return tmpCalendar.component(.weekday, from: date)
    }
    
    //スケジュール取得
    func getEvents(date: String) -> [(String, String)]{
        let realm = try! Realm()
        let result = realm.objects(Event.self).filter("date = '\(date)'")
        var eventArray: [(String, String)] = []
        for e in result {
            if e.date == date {
                eventArray.append((e.id, e.event))
            }
        }
        return eventArray
    }
    
    //スケジュール登録
    func setEvent(date: String, event: String){
        let realm = try! Realm()
        try! realm.write {
            realm.add(Event(value:["date": date, "event": event, "id": String(Date().timeIntervalSince1970)]))
        }
    }
    
    func removeEvent(id: String){
        let realm = try! Realm()
        try! realm.write {
            realm.delete(realm.objects(Event.self).filter("id = '\(id)'"))
        }
    }
}
