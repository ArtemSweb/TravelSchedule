//
//  DataProvider.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 23.07.2025.
//
import Foundation

actor DataProvider: DataProviderProtocol {
    static let shared = DataProvider()
    private let converter = DataConverter()
    private var settlements: [Settlement]?
    
    private init() {}
    
    func fetchSettlements() async throws -> [Settlement] {
        if let cachedSettlements = settlements {
            return cachedSettlements
        }
        
        let response = try await ServiceManager.shared.getStationsList()
        print(response.countries?.first?.title)
        let convertedSettlements = try converter.convertSettlements(from: response)
        settlements = convertedSettlements
        return convertedSettlements
    }
    
    func fetchRoutes(from stationFrom: Station, to stationTo: Station) async throws -> [Route] {
        let response = try await ServiceManager.shared.getScheduleBetweenStations(from: stationFrom.code, to: stationTo.code)
        return try converter.convertRoutes(from: response)
    }
}
