//
//  MainView.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 01.07.2025.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = StoriesViewModel()
    @State private var fromTofromTo = true
    @State private var showAgreement = false
    @ObservedObject var coordinator: NavCoordinator
    
    var body: some View {
        ZStack {
            Color.whiteApp
                .ignoresSafeArea()
            
            VStack(spacing: 44) {
                ScrollView (.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 12) {
                        ForEach(viewModel.sortedIndices(), id: \.self) { index in
                            Button {
                                viewModel.openStory(at: index)
                            } label: {
                                StoryCell(
                                    story: viewModel.stories[index],
                                    isViewed: viewModel.viewedStories.contains(index)
                                )
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                .frame(height: 140)
                .fullScreenCover(isPresented: $viewModel.showStories) {
                     StoriesView(
                         onViewed: { indices in
                             viewModel.markViewed(Array(indices))
                         }, stories: viewModel.stories,
                         initialIndex: viewModel.selectedStoryIndex
                     )
                     .preferredColorScheme(.dark)
                 }
                
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
                                        ? .gray
                                        : .blackUni
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
                                        ? .gray
                                        : .blackUni
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
                                    .foregroundStyle(.blue)
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
                        Button(action: {
                            coordinator.path.append(RouteEnum.tickets)
                        }) {
                            Text("Найти")
                                .font(.bold17)
                                .foregroundStyle(.whiteUni)
                        }
                        .padding(.horizontal, 47.5)
                        .padding(.vertical, 20)
                        .background(.blueUni)
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
}

#Preview {
    MainView(coordinator: NavCoordinator())
}
