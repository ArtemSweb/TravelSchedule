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
    
    // Добавляем хранилище для объектов
    @Published var selectedSettlementFrom: Settlement?
    @Published var selectedStationFromObject: Station?
    @Published var selectedSettlementTo: Settlement?
    @Published var selectedStationToObject: Station?
    
    var isFiltersValid: Bool {
        !timeFilters.isEmpty && showTransfers != nil
    }
    
    func resetSelection() {
        selectedCityFrom = ""
        selectedStationFrom = ""
        selectedCityTo = ""
        selectedStationTo = ""
        selectedSettlementFrom = nil
        selectedStationFromObject = nil
        selectedSettlementTo = nil
        selectedStationToObject = nil
    }
}
