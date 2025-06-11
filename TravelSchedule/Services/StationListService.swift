//
//  StationListService.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 11.06.2025.
//


import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

typealias StationsList = Components.Schemas.StationsList

protocol StationListServiceProtocol {
    func getStationsList() async throws -> StationsList
}

final class StationListService: StationListServiceProtocol {
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
      self.client = client
      self.apikey = apikey
    }
    
    func getStationsList() async throws -> StationsList {
        let response = try await client.getStationsList(query: .init(apikey: apikey))
        let data = try await Data(collecting: response.ok.body.html, upTo: 1024 * 1024 * 100)
        let stationsList = try JSONDecoder().decode(StationsList.self, from: data)
        
        return stationsList
    }
}
