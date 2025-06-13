//
//  CopyrightService.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 11.06.2025.
//

typealias Copyright = Components.Schemas.Copyright

protocol CopyrightServiceProtocol {
  func getCopyright() async throws -> Copyright
}

final class CopyrightService: CopyrightServiceProtocol {
    
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func getCopyright() async throws -> Copyright {
        let response = try await client.getCopyright(query: .init())
        
        return try response.ok.body.json
    }
    
}
