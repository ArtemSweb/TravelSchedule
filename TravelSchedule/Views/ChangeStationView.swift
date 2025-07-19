//
//  ChangeStationView.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 01.07.2025.
//


import SwiftUI

struct ChangeStationView: View {
    // MARK: - Properties
    @State private var searchText = ""
    @Environment(\.dismiss) var dismiss
    @ObservedObject var coordinator: NavCoordinator
    let city: String
    let fromField: Bool
    
    // MARK: - Private properties
    private let stations = [
        "Киевский вокзал",
        "Курский вокзал",
        "Ярославский вокзал",
        "Белорусский вокзал",
        "Савеловский вокзал",
        "Ленинградский вокзал"
    ]
    
    private var filteredItems: [String] {
        if searchText.isEmpty {
            return stations
        } else {
            return stations.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
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
            CustomSearchBar(text: $searchText, placeholder: "Введите запрос")
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
                if !filteredItems.isEmpty {
                    ForEach(filteredItems, id: \.self) { city in
                        stationButton(for: city)
                    }
                } else {
                    emptyState
                }
            }
        }
    }
    
    private func stationButton(for station: String) -> some View {
        Button(action: {
            if fromField {
                coordinator.selectedCityFrom = city
                coordinator.selectedStationFrom = station
            } else {
                coordinator.selectedCityTo = city
                coordinator.selectedStationTo = station
            }
            coordinator.path = NavigationPath()
        }) {
            HStack {
                Text(station)
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


#Preview {
    ChangeStationView(
        coordinator: NavCoordinator(),
        city: "Москва",
        fromField: true
    )
}
