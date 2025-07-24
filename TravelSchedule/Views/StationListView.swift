//
//  StationListView.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 01.07.2025.
//

import SwiftUI

struct StationListView: View {
    // MARK: - Properties
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: StationListViewModel
    
    let onStationSelected: (Station) -> Void
    let fromField: Bool
    
    // MARK: - Content
    var body: some View {
        ZStack {
            Color.whiteApp
                .ignoresSafeArea()
            
            content
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Private view
    private var content: some View {
        VStack(spacing: 0) {
            CustomSearchBar(text: $viewModel.searchText, placeholder: "Введите запрос")
            cityList
        }
        .padding(.horizontal, 16)
        .scrollIndicators(.hidden)
        .navigationBarBackButtonHidden(true)
        .toolbar { toolbarContent }
    }
    
    private var cityList: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading) {
                if viewModel.filteredStations.isEmpty && viewModel.isSearching {
                    emptyState
                } else {
                    ForEach(viewModel.filteredStations) { station in
                        stationButton(for: station)
                    }
                }
            }
        }
    }
    
    private func stationButton(for station: Station) -> some View {
        Button(action: {
            onStationSelected(station)
        }) {
            HStack {
                Text(station.title)
                    .font(.regular17)
                    .foregroundStyle(.blackApp)
                
                Spacer()
                
                Image(.chevronRight)
                    .renderingMode(.template)
                    .foregroundStyle(.blackApp)
            }
            .padding(.vertical, 19)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private var emptyState: some View {
        VStack {
            Text("Станция не найдена")
                .font(.bold24)
                .foregroundStyle(.blackApp)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 176)
        }
    }
    
    // MARK: - Toolbar
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: { dismiss() }) {
                Image(.chevronLeft)
                    .renderingMode(.template)
                    .foregroundStyle(.blackApp)
            }
        }

        ToolbarItem(placement: .principal) {
            Text("Выбор города")
                .font(.bold17)
                .foregroundStyle(.blackApp)
        }
    }
}


//#Preview {
//    StationListView(
//        coordinator: NavCoordinator(),
//        city: "Москва",
//        fromField: true
//    )
//}
