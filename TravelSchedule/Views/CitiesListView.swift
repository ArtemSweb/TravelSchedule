//
//  CitiesListView.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 01.07.2025.
//

import SwiftUI

// MARK: - CitiesListView

struct CitiesListView: View {
    
    // MARK: - Properties
    @State private var searchText = ""
    @Environment(\.dismiss) var dismiss
    @ObservedObject var coordinator: NavCoordinator
    @StateObject var viewModel = CitiesListViewModel()
    
    let fromField: Bool
    
    // MARK: - Private properties
    private let cities = [
        "Москва", "Санкт-Петербург", "Сочи",
        "Горный воздух", "Краснодар", "Казань", "Омск"
    ]

    private var filteredItems: [String] {
        guard !searchText.isEmpty else { return cities }
        return cities.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }
    
    // MARK: - Content
    var body: some View {
        ZStack {
            Color.whiteApp.ignoresSafeArea()
            content
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Private view

    private var content: some View {
        VStack(spacing: .zero) {
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
                        cityButton(for: city)
                    }
                } else {
                    emptyState
                }
            }
        }
    }
    
    private func cityButton(for city: String) -> some View {
        Button(action: {
            if fromField {
                coordinator.selectedCityFrom = city
                coordinator.selectedStationFrom = ""
            } else {
                coordinator.selectedCityTo = city
                coordinator.selectedStationTo = ""
            }
            coordinator.path.append(RouteEnum.stationPicker(city: city, fromField: fromField))
        }) {
            HStack {
                Text(city)
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
        .buttonStyle(.plain)
    }

    private var emptyState: some View {
        VStack {
            Text("Город не найден")
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

// MARK: - ChangeCityView_Preview

#Preview {
    CitiesListView(
        coordinator: NavCoordinator(),
        fromField: true
    )
}
