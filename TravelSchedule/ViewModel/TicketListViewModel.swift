//
//  TicketListViewModel.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 25.07.2025.
//
import Foundation

@MainActor
final class TicketListViewModel: ObservableObject, Identifiable {
    @Published private(set) var allRoutes: [Route] = []
    @Published private(set) var isLoading = false
    @Published private(set) var loadingFailed = false
    @Published private(set) var filters = Filters()
    
    let id = UUID()
    let settlementFrom: Settlement
    let stationFrom: Station
    let settlementTo: Settlement
    let stationTo: Station
    
    var title: String {
        "\(settlementFrom.title) (\(stationFrom.title)) → \(settlementTo.title) (\(stationTo.title))"
    }
    var filteredRoutes: [Route] {
        if filters.isEmpty {
            return allRoutes
        } else {
            return allRoutes.filter { $0.matchesFilters(filters) }
        }
    }
        
    private let dataProvider: DataProviderProtocol
    
    init(
        settlementFrom: Settlement,
        stationFrom: Station,
        settlementTo: Settlement,
        stationTo: Station,
        dataProvider: DataProviderProtocol = DataProvider.shared
    ) {
        self.settlementFrom = settlementFrom
        self.stationFrom = stationFrom
        self.settlementTo = settlementTo
        self.stationTo = stationTo
        self.dataProvider = dataProvider
    }
    
    func applyFilters(value newValue: Filters) {
        filters = newValue
    }
    
    func fetchRoutes() async {
        isLoading = true
        loadingFailed = false
        do {
            allRoutes = try await dataProvider.fetchRoutes(from: stationFrom, to: stationTo)
        } catch {
            print(error.localizedDescription)
            loadingFailed = true
        }
        isLoading = false
    }
}
