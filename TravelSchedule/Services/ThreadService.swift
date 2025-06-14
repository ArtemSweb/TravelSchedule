//
//  ThreadService.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 10.06.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias ThreadStations = Components.Schemas.Thread

protocol ThreadServiceProtocol {
    func getThread(uid: String) async throws -> ThreadStations
}

final class ThreadService: ThreadServiceProtocol {
    private let client: Client
    
    init(client: Client) {
      self.client = client
    }
    
    func getThread(uid: String) async throws -> ThreadStations {
        let response = try await client.getThread(query: .init(
            uid: uid))
        
        return try response.ok.body.json
    }
}
