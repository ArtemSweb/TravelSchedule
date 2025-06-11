//
//  ServiceManager.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 11.06.2025.
//

import OpenAPIURLSession

final class ServiceManager {
    static let shared = ServiceManager()
    private init() {}

    private var searchService: SearchService?
    private var scheduleService: ScheduleService?
    private var threadService: ThreadService?
    private var nearestStationsService: NearestStationsService?
    private var nearestSettlementService: NearestSettlementService?
    private var carrierService: CarrierService?
    private var stationListService: StationListService?
    private var copyrightService: CopyrightService?
    
    private let apiKey = Constants.apiKey
    
    private var client: Client? {
        NetworkManager.shared?.client
    }
    
    // MARK: - Schedule Between Stations
    func getScheduleBetweenStations(from: String, to: String) async throws -> ScheduleBetweenStations {
        guard let client = client else { throw NetworkError.clientUnavailable }
        
        if searchService == nil {
            searchService = SearchService(client: client, apikey: apiKey)
        }
        
        guard let service = searchService else {
            throw NetworkError.serviceInitializationFailed
        }
        
        return try await service.getSheduleBetweenStation(from: from, to: to)
    }
    
    
    // MARK: - Schedule for Station
    func getScheduleForStation(station: String) async throws -> ListOfSchedules {
        guard let client = client else { throw NetworkError.clientUnavailable }
        
        if scheduleService == nil {
            scheduleService = ScheduleService(client: client, apikey: apiKey)
        }
        
        guard let service = scheduleService else {
            throw NetworkError.serviceInitializationFailed
        }
        
        return try await service.getScheduleForStation(station: station)
    }
    
    // MARK: - Schedule Thread
    func getScheduleThread(uid: String) async throws -> ThreadStations {
        guard let client = client else { throw NetworkError.clientUnavailable }
        
        if threadService == nil {
            threadService = ThreadService(client: client, apikey: apiKey)
        }
        
        guard let service = threadService else {
            throw NetworkError.serviceInitializationFailed
        }
        
        return try await service.getThread(uid: uid)
    }

    // MARK: - Nearest Stations
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        guard let client = client else { throw NetworkError.clientUnavailable }
        
        if nearestStationsService == nil {
            nearestStationsService = NearestStationsService(client: client, apikey: apiKey)
        }
        
        guard let service = nearestStationsService else {
            throw NetworkError.serviceInitializationFailed
        }
        
        return try await service.getNearestStations(lat: lat, lng: lng, distance: distance)
    }
    
    // MARK: - Nearest Settlement
    func getNearestSettlement(lat: Double, lng: Double) async throws -> NearestSettlement {
        guard let client = client else { throw NetworkError.clientUnavailable }
        
        if nearestSettlementService == nil {
            nearestSettlementService = NearestSettlementService(client: client, apikey: apiKey)
        }
        
        guard let service = nearestSettlementService else {
            throw NetworkError.serviceInitializationFailed
        }
        
        return try await service.getNearestSettlement(lat: lat, lng: lng)
    }
    
    // MARK: - Carrier
    func getCarrier(code: String) async throws -> Carrier {
        guard let client = client else { throw NetworkError.clientUnavailable }
        
        if carrierService == nil {
            carrierService = CarrierService(client: client, apikey: apiKey)
        }
        
        guard let service = carrierService else {
            throw NetworkError.serviceInitializationFailed
        }
        return try await service.getCarrier(code: code)
    }
    
    // MARK: - Stations List
    func getStationsList() async throws -> StationsList {
        guard let client = client else { throw NetworkError.clientUnavailable }
        
        if stationListService == nil {
            stationListService = StationListService(client: client, apikey: apiKey)
        }
        
        guard let service = stationListService else {
            throw NetworkError.serviceInitializationFailed
        }
        
        return try await service.getStationsList()
    }
    
    // MARK: - Copyright
    func getCopyright() async throws -> Copyright {
        guard let client = client else { throw NetworkError.clientUnavailable }
        
        if copyrightService == nil {
            copyrightService = CopyrightService(client: client, apikey: apiKey)
        }
        
        guard let service = copyrightService else {
            throw NetworkError.serviceInitializationFailed
        }
        
        return try await service.getCopyright()
    }
}

// MARK: - Error Handling
enum NetworkError: Error {
    case clientUnavailable
    case serviceInitializationFailed
}
