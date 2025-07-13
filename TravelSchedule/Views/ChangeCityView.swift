//
//  ChangeCityView.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 01.07.2025.
//

import SwiftUI

struct ChangeCityView: View {
    @State private var searchText = ""
    @Environment(\.dismiss) var dismiss
    @ObservedObject var coordinator: NavCoordinator
    let fromField: Bool
    
    let cities = ["Москва",
                  "Санкт-Петербург",
                  "Сочи",
                  "Горный воздух",
                  "Краснодар",
                  "Казань",
                  "Омск"]
    
    var filteredItems: [String] {
        guard !searchText.isEmpty else { return cities }
        return cities.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            CustomSearchBar(text: $searchText, placeholder: "Введите запрос")
            
            ScrollView(.vertical) {
                LazyVStack(alignment: .leading) {
                    if !filteredItems.isEmpty {
                        ForEach(filteredItems, id: \.self) { item in
                            Button(action: {
                                if fromField {
                                    coordinator.selectedCityFrom = item
                                    coordinator.selectedStationFrom = ""
                                } else {
                                    coordinator.selectedCityTo = item
                                    coordinator.selectedStationTo = ""
                                }
                                coordinator.path.append(RouteEnum.stationPicker(city: item, fromField: fromField))
                            }) {
                                HStack {
                                    Text("\(item)")
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
                    } else {
                        VStack {
                            Text("Город не найден")
                                .font(.bold24)
                                .foregroundStyle(.blackApp)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 176)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .scrollIndicators(.hidden)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
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
}

#Preview {
    ChangeCityView(coordinator: NavCoordinator(), fromField: true)
}
