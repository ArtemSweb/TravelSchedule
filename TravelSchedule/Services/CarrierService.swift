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
    
    enum CarrierServiceError: Error {
        case missingCarrier
    }
    
    init(client: Client) {
      self.client = client
    }
    
    func getCarrier(code: String) async throws -> Carrier {
        let response = try await client.getCarrier(query: .init(
            code: code
        ))
        
        guard let carrier = try response.ok.body.json.carrier else {
            throw CarrierServiceError.missingCarrier
        }
        
        return carrier
    }
}
