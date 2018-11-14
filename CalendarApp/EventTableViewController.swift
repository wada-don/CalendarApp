//
//  EventTableViewController.swift
//  CalendarApp
//
//  Created by Ryusei Wada on 2018/11/13.
//  Copyright © 2018年 Ryusei Wada. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController {
    var eventArray: [(String, String)] = []
    var calendarModel: CalendarModel = CalendarModel()
    var selectDay = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        eventArray = calendarModel.getEvents(date: selectDay)
        print(eventArray)
    }

    // Sectionの個数
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Cellの個数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }

    // Cellの設定
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = eventArray[indexPath.row].1
        return cell
    }
    
    // Cellタップ時の挙動
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }

    // 予定を削除
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            calendarModel.removeEvent(id: eventArray[indexPath.row].0)
            eventArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
