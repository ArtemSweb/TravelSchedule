//
//  DataProviderProtocol.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 23.07.2025.
//

import Foundation

protocol DataProviderProtocol: Actor {
    func fetchSettlements() async throws -> [Settlement]
    func fetchRoutes(from: Station, to: Station) async throws -> [Route]
}
