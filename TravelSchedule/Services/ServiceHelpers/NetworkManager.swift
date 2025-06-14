//
//  NetworkManager.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 12.06.2025.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    let client: Client
    
    private init?() {
        guard let createdClient = ClientFactory.createClient() else { return nil }
        self.client = createdClient
    }
}
