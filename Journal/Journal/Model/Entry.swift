//
//  Entry.swift
//  Journal
//
//  Created by Benjamin Tincher on 1/11/21.
//

import Foundation

class Entry: Codable {
    var title: String
    var body: String
    let timestamp: String

    init(title: String, body: String, timestamp: String = Date().dateToString(format: .full)) {
        self.title = title
        self.body = body
        self.timestamp = timestamp
    }
}

extension Entry: Equatable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.title == rhs.title && lhs.body == rhs.body && lhs.timestamp == rhs.timestamp
    }
}

extension Date {
    
//    Wednesday, Sep 12, 2018           --> EEEE, MMM d, yyyy
//    09/12/2018                        --> MM/dd/yyyy
//    09-12-2018 14:11                  --> MM-dd-yyyy HH:mm
//    Sep 12, 2:11 PM                   --> MMM d, h:mm a
//    September 2018                    --> MMMM yyyy
//    Sep 12, 2018                      --> MMM d, yyyy
//    Wed, 12 Sep 2018 14:11:54 +0000   --> E, d MMM yyyy HH:mm:ss Z
//    2018-09-12T14:11:54+0000          --> yyyy-MM-dd'T'HH:mm:ssZ
//    12.09.18                          --> dd.MM.yy
//    10:41:02.112                      --> HH:mm:ss.SSS

     enum DateFormatType: String {
        case full = "EEEE, MMM d, yyyy"
        case fullNumeric = "MM/dd/yyyy"
        case fullNumericTimestamp = "MM-dd-yyyy HH:mm"
        case monthDayTimestamp = "MMM d, h:mm a"
        case monthDayYearTimestamp = "MMM d yyyy, h:mm a"
        case monthYear = "MMMM yyyy"
        case monthDayYear = "MMM d, yyyy"
        case fullWithTimezone = "E, d MMM yyyy HH:mm:ss Z"
        case fullNumericWithTimezone = "yyyy-MM-dd'T'HH:mm:ssZ"
        case short = "dd.MM.yy"
        case timestamp = "HH:mm:ss.SSS"
     }
    
    func dateToString(format: DateFormatType) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
}
