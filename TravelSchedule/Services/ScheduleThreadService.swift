import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleThread = Components.Schemas.Thread

protocol ScheduleThreadServiceProtocol {
    func getThread(uid: String) async throws -> ScheduleThread
}

final class ScheduleThreadService: ScheduleThreadServiceProtocol {
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func getThread(uid: String) async throws -> ScheduleThread {
        let response = try await client.getThread(query: .init(
            uid: uid
        ))
        return try response.ok.body.json
    }
}
