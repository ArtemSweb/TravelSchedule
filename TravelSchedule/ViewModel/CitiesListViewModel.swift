//
//  CitiesListViewModel.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 22.07.2025.
//

import SwiftUI

@MainActor
final class CitiesListViewModel: ObservableObject {
    @Published private(set) var allSettlements: [City] = []
    @Published private(set) var isLoading = false
    @Published private(set) var loadingFaild = false
    @Published private(set) var searchText: String = ""
    
}
