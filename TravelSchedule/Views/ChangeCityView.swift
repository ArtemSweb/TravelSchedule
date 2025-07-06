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
        if searchText.isEmpty {
            return cities
        } else {
            return cities.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomSearchBar(text: $searchText, placeholder: "Введите запрос")
            
            ScrollView(.vertical, showsIndicators: false) {
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
                                        .font(.system(size: 17, weight: .regular))
                                        .foregroundStyle(Color(.black))
                                    
                                    Spacer()
                                    
                                    Image(.chevronRight)
                                        .renderingMode(.template)
                                        .foregroundStyle(Color(.black))
                                }
                                .padding(.vertical, 19)
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    } else {
                        VStack {
                            Text("Город не найден")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundStyle(Color(.black))
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 176)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(.chevronLeft)
                        .renderingMode(.template)
                        .foregroundStyle(Color(.black))
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("Выбор города")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(Color(.black))
            }
        }
    }
}

#Preview {
    ChangeCityView(coordinator: NavCoordinator(), fromField: true)
}
