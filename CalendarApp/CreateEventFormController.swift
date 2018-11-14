//
//  CreateEventFormController.swift
//  CalendarApp
//
//  Created by Ryusei Wada on 2018/11/14.
//  Copyright © 2018年 Ryusei Wada. All rights reserved.
//

import UIKit
import RealmSwift
import Eureka

class CreateEventViewController: FormViewController {
    
    @IBOutlet var saveButton: UIBarButtonItem!
    
    var calendarModel = CalendarModel()
    var selectDay: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Eurekaでフォームを作成
        form
            +++ Section("Event")
            <<< TextRow("EventRow"){ row in
                row.title = "予定"
                row.placeholder = "Enter text here"
            }
            
            <<< DateInlineRow("DateRow"){
                $0.title = "日時"
                $0.value = Calendar(identifier: .gregorian).date(byAdding: .year, value: 0, to: Date())
        }
    }
    
    @IBAction func saveEvent(){
        // 入力フォームが空だった時のバリデーション
        let errors = form.validate()
        guard errors.isEmpty else {
            print("validate errors:", errors)
            return
        }
        
        // イベント登録
        let eventRow = form.rowBy(tag: "EventRow") as! TextRow
        let dateRow = form.rowBy(tag: "DateRow") as! DateInlineRow
        calendarModel.setEvent(date: calendarModel.getDay(dateRow.value!), event: eventRow.value!)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
}
