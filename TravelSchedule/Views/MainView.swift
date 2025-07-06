//
//  MainView.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 01.07.2025.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = ReelsViewModel()
    @State private var fromTofromTo = true
    @State private var showAgreement = false
    @ObservedObject var coordinator: NavCoordinator
    
    var body: some View {
        VStack (spacing: 44){
            ScrollView (.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .center, spacing: 12) {
                    ForEach(viewModel.reels) { reels in
                        ReelsCell(reels: reels)
                    }
                }
                .padding(.horizontal, 16)
            }
            .frame(height: 140)
            VStack(spacing: 16) {
                ZStack {
                    Color(UIColor(resource: .blueUni))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            NavigationLink(value: RouteEnum.cityPicker(fromField: true)) {
                                Text(fromTofromTo ? (coordinator.selectedCityFrom.isEmpty ? "Откуда" : "\(coordinator.selectedCityFrom) (\(coordinator.selectedStationFrom))")
                                     : (coordinator.selectedCityTo.isEmpty ? "Куда" : "\(coordinator.selectedCityTo) (\(coordinator.selectedStationTo))")
                                )
                                .foregroundStyle(
                                    (fromTofromTo
                                     ? coordinator.selectedCityFrom.isEmpty
                                     : coordinator.selectedCityTo.isEmpty
                                    )
                                    ? Color(.gray)
                                    : Color(.blackUni)
                                )
                                .padding(.vertical, 14)
                                .padding(.horizontal, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            NavigationLink(value: RouteEnum.cityPicker(fromField: false)) {
                                Text(fromTofromTo ? (coordinator.selectedCityTo.isEmpty ? "Куда" : "\(coordinator.selectedCityTo) (\(coordinator.selectedStationTo))")
                                     : (coordinator.selectedCityFrom.isEmpty ? "Откуда" : "\(coordinator.selectedCityFrom) (\(coordinator.selectedStationFrom))")
                                )
                                .foregroundStyle(
                                    (fromTofromTo
                                     ? coordinator.selectedCityTo.isEmpty
                                     : coordinator.selectedCityFrom.isEmpty
                                    )
                                    ? Color(.gray)
                                    : Color(.blackUni)
                                )
                                .padding(.vertical, 14)
                                .padding(.horizontal, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white)
                        )
                        .padding(.horizontal, 16)
                        
                        Button(action: { fromTofromTo.toggle() }) {
                            Image(.changeButtonIcon)
                                .font(.system(size: 24))
                                .foregroundStyle(Color(.blue))
                                .padding(6)
                                .background(.white)
                                .clipShape(Circle())
                        }
                        .padding(.trailing, 16)
                    }
                    .padding(.vertical, 16)
                }
                .frame(height: 128)
                .padding(.horizontal, 16)
                
                if !coordinator.selectedCityTo.isEmpty && !coordinator.selectedCityFrom.isEmpty {
                    Button(action: {coordinator.path.append(RouteEnum.tickets)}) {
                        Text("Найти")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundStyle(Color(.whiteUni))
                    }
                    .padding(.horizontal, 47.5)
                    .padding(.vertical, 20)
                    .background(Color(.blue))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
            Spacer()
            
            Divider()
                .frame(height: 3)
        }
        .padding(.top, 24)
    }
}

#Preview {
    MainView(coordinator: NavCoordinator())
}
