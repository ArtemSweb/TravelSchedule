//
//  SearchService.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 09.06.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias SheduleBetweenStations = Components.Schemas.SearchSchema

protocol SearchServiceProtocol {
    func  getSheduleBetweenStation(from: String, to: String, date: String) async throws -> SheduleBetweenStations
}

final class SearchService: SearchServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getSheduleBetweenStation(from: String, to: String, date: String) async throws -> SheduleBetweenStations {
        let response = try await client.getSearch(query: .init(
            apikey: apikey,
            from: from,
            to: to))
        return try response.ok.body.json
    }
}
