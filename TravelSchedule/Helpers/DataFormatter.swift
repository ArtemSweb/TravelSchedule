//
//  DateFormatterProvider.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 25.07.2025.
//

import Foundation

final class DateFormatterProvider {
    static let shared = DateFormatterProvider()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM"
        formatter.locale = Locale.current
        return formatter
    }()
    
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    private init() {}
}
