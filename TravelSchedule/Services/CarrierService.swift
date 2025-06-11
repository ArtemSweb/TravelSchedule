//
//  CarrierService.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 10.06.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Carrier = Components.Schemas.Carrier

protocol CarrierServiceProtocol {
    func getCarrier(code: String) async throws -> Carrier
}

final class CarrierService: CarrierServiceProtocol {
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
      self.client = client
      self.apikey = apikey
    }
    
    func getCarrier(code: String) async throws -> Carrier {
        let response = try await client.getCarrier(query: .init(
            apikey: apikey,
            code: code
        ))

        return try response.ok.body.json
    }
}
