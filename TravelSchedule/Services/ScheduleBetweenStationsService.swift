import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleBetweenStations = Components.Schemas.ScheduleBetweenStations

protocol ScheduleBetweenStationsServiceProtocol {
    func getScheduleBetweenStations(from: String, to: String) async throws -> ScheduleBetweenStations
}

final class ScheduleBetweenStationsService: ScheduleBetweenStationsServiceProtocol {
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func getScheduleBetweenStations(from stationFrom: String, to stationTo: String) async throws -> ScheduleBetweenStations {
        let response = try await client.getScheduleBetweenStations(query: .init(
            from: stationFrom,
            to: stationTo
        ))
        return try response.ok.body.json
    }
}
