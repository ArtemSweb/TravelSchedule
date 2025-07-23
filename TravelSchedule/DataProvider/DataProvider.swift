//
//  DataProvider.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 23.07.2025.
//

import Foundation

actor DataProvider {
    static let shared = DataProvider()
    private let converter = DataConverter()
    private var cities: [City]?
    
    private init() {}
    
    func loadCities() async throws -> [City] {
        let response = try await ServiceManager.shared.getStationsList()
        let convertedCities = try converter.convertSettlements(from: response)
        cities = convertedCities
        return convertedCities
    }
}
