//
//  CitiesListViewModel.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 22.07.2025.
//
import SwiftUI

@MainActor
final class CitiesListViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var isLoading = false
    @Published var loadingFailed = false
    @Published var allSettlements: [Settlement] = []
    
    private let dataProvider: DataProviderProtocol
    
    var isSearching: Bool {
        !searchText.isEmpty
    }
    
    var filteredSettlements: [Settlement] {
        if searchText.isEmpty {
            return allSettlements
        } else {
            return allSettlements.filter { $0.title.starts(with: searchText) }
        }
    }
    
    init(dataProvider: DataProviderProtocol = DataProvider.shared) {
        self.dataProvider = dataProvider
    }
    
    func fetchSettlements() async {
        print("CitiesListViewModel: fetchSettlements")
        guard !isLoading else { return }
        isLoading = true
        loadingFailed = false
        do {
            allSettlements = try await dataProvider.fetchSettlements()
            isLoading = false
        } catch {
            if !(error is CancellationError){
                print(error.localizedDescription)
                loadingFailed = true
            }
        }
    }
}
