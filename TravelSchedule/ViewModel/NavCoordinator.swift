//
//  NavCoordinator.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 01.07.2025.
//

import SwiftUI

final class NavCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var selectedCityFrom: String = ""
    @Published var selectedStationFrom: String = ""
    @Published var selectedCityTo: String = ""
    @Published var selectedStationTo: String = ""
    @Published var timeFilters: Set<PeriodicEnum> = []
    @Published var showTransfers: Bool? = nil
    @Published var selectedStationFromCode: String = ""
    @Published var selectedStationToCode: String = ""
    
    var isFiltersValid: Bool {
        !timeFilters.isEmpty && showTransfers != nil
    }
}
