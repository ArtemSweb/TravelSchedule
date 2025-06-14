//
//  ClientFactory.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 12.06.2025.
//

import OpenAPIURLSession

struct ClientFactory {
    static func createClient() -> Client? {
        do {
            return try Client(
                serverURL: Servers.Server1.url(),
                transport: URLSessionTransport(),
                middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: Constants.apiKey)]
            )
        } catch {
            print("Failed to create client: \(error.localizedDescription)")
            return nil
        }
    }
}
