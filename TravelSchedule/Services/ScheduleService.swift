//
//  ScheduleService.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 09.06.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias ListOfSchedules = Components.Schemas.ScheduleSchema

protocol ScheduleServiceProtocol {
    func getScheduleForStation(station: String) async throws -> ListOfSchedules
}

final class ScheduleService: ScheduleServiceProtocol {
    private let client: Client
    
    init(client: Client) {
      self.client = client
    }
    
    func getScheduleForStation(station: String) async throws -> ListOfSchedules {
        let response = try await client.getSchedule(query: .init(
            station: station))
        
        return try response.ok.body.json
    }
}
