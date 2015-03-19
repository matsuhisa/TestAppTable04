//  Memo.swift
//  TestAppTable04

import Foundation
import UIKit

class Memo: NSObject {
    
    var title:String
    var body:String
    var created_at:NSDate = NSDate()
    var modified_at:NSDate = NSDate()
    
    init(body:String) {
        self.title = "無題"
        self.body  = body
    }
    
    init(title:String, body:String) {
        self.title = title
        self.body  = body
    }
    
    func created_at_string() -> String {
        
        var change_date = self.created_at
        
        var date_formatter: NSDateFormatter = NSDateFormatter()
        date_formatter.locale     = NSLocale(localeIdentifier: "ja")
        date_formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        let weekdays: Array  = [nil, "日", "月", "火", "水", "木", "金", "土"]
        let calender: NSCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        let comps: NSDateComponents = calender.components(NSCalendarUnit.YearCalendarUnit|NSCalendarUnit.MonthCalendarUnit|NSCalendarUnit.DayCalendarUnit|NSCalendarUnit.HourCalendarUnit|NSCalendarUnit.MinuteCalendarUnit|NSCalendarUnit.SecondCalendarUnit|NSCalendarUnit.WeekdayCalendarUnit, fromDate: change_date)
        
        date_formatter.dateFormat = "yyyy年MM月dd日（\(weekdays[comps.weekday])） HH時mm分ss秒"
        
        return date_formatter.stringFromDate(change_date)
    }
}
