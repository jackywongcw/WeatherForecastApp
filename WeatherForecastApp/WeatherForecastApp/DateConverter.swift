//
//  DateConverter.swift
//  WeatherForecastApp
//
//  Created by Jacky Wong on 22/4/19.
//  Copyright © 2019 Jacky Wong. All rights reserved.
//

import Foundation

extension Date {
    
    func toLocalisedDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "SGT")
        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }
    
    func toLocalisedTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "SGT")
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }
    
}

