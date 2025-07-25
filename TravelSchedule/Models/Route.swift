//
//  Route.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 23.07.2025.
//

import Foundation

struct Filters {
    var dayParts: Set<PeriodicEnum>
    var showTransfers: Bool?
    
    var isEmpty: Bool {
        dayParts.isEmpty && showTransfers == nil
    }
    
    init(dayParts: Set<PeriodicEnum>, showTransfers: Bool? = nil) {
        self.dayParts = dayParts
        self.showTransfers = showTransfers
    }
    
    init() {
        self.dayParts = Set()
    }
}

struct Route: Hashable, Identifiable, Sendable {
    let id: String
    let date: Date
    let departure: Date
    let arrival: Date
    let durationSeconds: Int
    let hasTransfers: Bool
    let transferPoint: String?
    let carrier: Carrier
    
    var dayPart: PeriodicEnum {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: departure)
        
        switch hour {
        case 6..<12:
            return .morning
        case 12..<18:
            return .day
        case 18..<24:
            return .evening
        default: // Hours 0..<6
            return .night
        }
    }
    
    func matchesFilters(_ filters: Filters) -> Bool {
        guard !filters.isEmpty else {
            return true
        }
        
        if !filters.dayParts.isEmpty && !filters.dayParts.contains(self.dayPart) {
            return false
        }
        
        if let showTransfers = filters.showTransfers,
           showTransfers != self.hasTransfers {
            return false
        }
        
        return true
    }
}
