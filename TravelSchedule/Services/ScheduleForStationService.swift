import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleForStation = Components.Schemas.ScheduleForStation

protocol ScheduleForStationServiceProtocol {
    func getScheduleForStation(_: String) async throws -> ScheduleForStation
}

final class ScheduleForStationService: ScheduleForStationServiceProtocol {
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func getScheduleForStation(_ station: String) async throws -> ScheduleForStation {
        let response = try await client.getScheduleForStation(query: .init(
            station: station
        ))
        return try response.ok.body.json
    }
}

