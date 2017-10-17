//
//  ConvertTimestampToDateHelper.swift
//  weather
//
//  Created by muu van duy on 2017/01/16.
//  Copyright © 2017 muuvanduy. All rights reserved.
//

import Foundation


class ConvertTimestampToDateHelper {
   
    var timestamp: Double
    var date: Date
    
    let dateFormater = DateFormatter()
    let localDate: Locale
    let calendar: Calendar
    
    let weekdays = ["SUNDAY", "MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY"]
    
    init(timestamp: TimeInterval) {
        self.timestamp = timestamp
        self.date = Date(timeIntervalSince1970: self.timestamp)
        self.dateFormater.timeStyle = DateFormatter.Style.medium // set time style
        self.dateFormater.dateStyle =  DateFormatter.Style.none //DateFormatter.Style.short // set date style
        self.dateFormater.dateFormat =  "MM/dd" //DateFormatter.Style.short // set date style
        self.localDate = NSLocale.current
        self.calendar = Calendar(identifier: .japanese)
        
        
    }
    
    func getDayOfWeek()-> String {
        let weekday = self.calendar.component(.weekday, from: date) - 1
        
        return self.weekdays[weekday]
    }
    
    func getDate()-> String {
        return self.dateFormater.string(from: self.date as Date)
    }
    
    func getTimeZone()-> String {
        return ""
    }
    
    func getUTCTime()-> String {
        let formatter = self.dateFormater
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        return formatter.string(from: self.date as Date)
    }
    
}

