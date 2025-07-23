//
//  City.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 22.07.2025.
//

import Foundation

struct City: Identifiable, Hashable, Sendable {
    let id = UUID()
    let title: String
    let stations: [Station]
}
