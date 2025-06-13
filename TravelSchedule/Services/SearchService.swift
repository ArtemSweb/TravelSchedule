//
//  SearchService.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 09.06.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleBetweenStations = Components.Schemas.SearchSchema

protocol SearchServiceProtocol {
    func  getSheduleBetweenStation(from: String, to: String) async throws -> ScheduleBetweenStations
}

final class SearchService: SearchServiceProtocol {
    private let client: Client
    
    init(client: Client) {
        self.client = client

    }
    
    func getSheduleBetweenStation(from: String, to: String) async throws -> ScheduleBetweenStations {
        let response = try await client.getSearch(query: .init(
            from: from,
            to: to))
        return try response.ok.body.json
    }
}
