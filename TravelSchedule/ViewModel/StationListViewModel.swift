//
//  StationListViewModel.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 24.07.2025.
//

import Foundation

@MainActor
final class StationListViewModel: ObservableObject {
    @Published private(set) var allStations: [Station]
    @Published var searchText: String = ""
    
    var isSearching: Bool {
        !searchText.isEmpty
    }
    
    var filteredStations: [Station] {
        if searchText.isEmpty {
            return allStations
        } else {
            return allStations.filter { $0.title.starts(with: searchText) }
        }
    }

    init(settlement: Settlement) {
        self.allStations = settlement.stations
    }
}

struct SelectedStation {
    let settlement: Settlement
    let station: Station
}
