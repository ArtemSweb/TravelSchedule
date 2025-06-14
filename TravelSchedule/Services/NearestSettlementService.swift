//
//  NearestSettlementService.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 10.06.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias NearestSettlement = Components.Schemas.Settlement

protocol NearestSettlementServiceProtocol {
    func getNearestSettlement(lat: Double, lng: Double) async throws -> NearestSettlement
}

final class NearestSettlementService: NearestSettlementServiceProtocol {
    private let client: Client
    
    init(client: Client) {
      self.client = client
    }
    
    func getNearestSettlement(lat: Double, lng: Double) async throws -> NearestSettlement {
        let response = try await client.getNearestSettlement(query: .init(
            lat: lat,
            lng: lng
        ))
        
        return try response.ok.body.json
    }
}
