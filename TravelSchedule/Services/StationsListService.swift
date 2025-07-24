import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias StationsList = Components.Schemas.StationsList

protocol StationsListServiceProtocol {
    func getStationsList() async throws -> StationsList
}

final class StationsListService: StationsListServiceProtocol {
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func getStationsList() async throws -> StationsList {
        let response = try await client.getStationsList(query: .init())
                
        let data = try await Data(collecting: response.ok.body.html, upTo: 1024 * 1024 * 100)
        let stationsList = try JSONDecoder().decode(StationsList.self, from: data)
        
        return stationsList
    }
}


