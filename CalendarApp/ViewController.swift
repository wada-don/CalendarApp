//
//  ViewController.swift
//  calender_app
//
//  Created by Ryusei Wada on 2018/11/11.
//  Copyright © 2018年 Ryusei Wada. All rights reserved.
//

import UIKit
import FSCalendar
import Realm
import RealmSwift

class ViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    @IBOutlet var calendar: FSCalendar!
    
    var calendarModel = CalendarModel()
    var selectDay: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calendar.dataSource = self
        self.calendar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        calendar.reloadData()
    }
    
    @IBAction func toCreateEvent(){
        self.performSegue(withIdentifier: "toCreateEvent", sender: nil)
    }
    
    // カレンダーのタップイベント
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
        selectDay = calendarModel.getDay(date)
        self.performSegue(withIdentifier: "toEventTableView", sender: selectDay)
    }
    
    // 土日や祝日の日の文字色を変える
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        // 祝日判定をする（祝日は赤色で表示する）
        if calendarModel.judgeHoliday(date){
            return UIColor.red
        }
        
        // 土日の判定を行う（土曜日は青色、日曜日は赤色で表示する）
        let weekday = calendarModel.getWeekIdx(date)
        if weekday == 1 {   //日曜日
            return UIColor.red
        }
        else if weekday == 7 {  //土曜日
            return UIColor.blue
        }
        
        return nil
    }
    
    // イベントがある日にドットをつける
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let events = calendarModel.getEvents(date: calendarModel.getDay(date as Date))
        return events.count
    }
    
    // セグエを選択した時の動作
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEventTableView" {
            let eventTableViewController = segue.destination as! EventTableViewController
            guard let sendValue = sender else{
                return
            }
            eventTableViewController.selectDay = sendValue as! String
        }
    }
}
