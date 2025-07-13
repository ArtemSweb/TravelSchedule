//
//  ChangeStationView.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 01.07.2025.
//


import SwiftUI

struct ChangeStationView: View {
    @State private var searchText = ""
    @Environment(\.dismiss) var dismiss
    @ObservedObject var coordinator: NavCoordinator
    let city: String
    let fromField: Bool
    
    let stations = [
        "Киевский вокзал",
        "Курский вокзал",
        "Ярославский вокзал",
        "Белорусский вокзал",
        "Савеловский вокзал",
        "Ленинградский вокзал"
    ]
    
    var filteredItems: [String] {
        if searchText.isEmpty {
            return stations
        } else {
            return stations.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomSearchBar(text: $searchText, placeholder: "Введите запрос")
            
            ScrollView(.vertical) {
                LazyVStack(alignment: .leading) {
                    if filteredItems.isEmpty {
                        VStack {
                            Text("Станция не найдена")
                                .font(.bold24)
                                .foregroundStyle(.blackApp)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 176)
                        }
                    } else {
                        ForEach(filteredItems, id: \.self) { item in
                            Button(action: {
                                if fromField {
                                    coordinator.selectedCityFrom = city
                                    coordinator.selectedStationFrom = item
                                } else {
                                    coordinator.selectedCityTo = city
                                    coordinator.selectedStationTo = item
                                }
                                coordinator.path = NavigationPath()
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
                Text("Выбор станции")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(.blackApp)
            }
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
