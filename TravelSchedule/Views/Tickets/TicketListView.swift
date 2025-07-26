//
//  TicketListView.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 01.07.2025.
//

import SwiftUI

struct TicketListView: View {
    @ObservedObject var coordinator: NavCoordinator
    @ObservedObject var viewModel: TicketListViewModel
    @Environment(\.dismiss) var dismiss
    @State private var fetchTask: Task<Void, Never>?
    
    private func updateFilters() {
            let newFilters = Filters(
                dayParts: coordinator.timeFilters,
                showTransfers: coordinator.showTransfers
            )
            viewModel.applyFilters(value: newFilters)
        }
    
    var body: some View {
        ZStack {
            Color.whiteApp
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                RouteHeaderView(title: viewModel.title)
                
                // Состояния загрузки
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxHeight: .infinity)
                } else if viewModel.loadingFailed {
                    ErrorView(errorType: .serverError)
                } else {
                    if !viewModel.filteredRoutes.isEmpty {
                        ZStack(alignment: .bottom) {
                            TicketsScrollView(routes: viewModel.filteredRoutes, coordinator: coordinator)
                            
                            FilterButton(coordinator: coordinator, viewModel: viewModel)
                                .padding(.bottom, 24)
                        }
                    } else {
                        EmptyTicketsView()
                        Spacer()
                    }
                    
                }
            }
            .padding(.horizontal, 16)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton(action: { dismiss() })
                }
            }
        }
        .task {
            fetchTask = Task {
                await viewModel.fetchRoutes()
            }
        }
        .onAppear {
            updateFilters() // Применяем начальные фильтры
        }
        .onChange(of: coordinator.timeFilters) { _, _ in
            updateFilters() // Реагируем на изменение периодов
        }
        .onChange(of: coordinator.showTransfers) { _, _ in
            updateFilters() // Реагируем на изменение фильтра пересадок
        }
    }
}

// MARK: - Subviews

private struct RouteHeaderView: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.bold24)
                .foregroundStyle(.blackApp)
                .multilineTextAlignment(.leading)
            Spacer()
        }
    }
}

private struct TicketsScrollView: View {
    let routes: [Route]
    let coordinator: NavCoordinator
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(routes) { route in
                    TicketButton(ticket: route, action: {
                        coordinator.path.append(RouteEnum.carrierInfo(route))
                    })
                }
            }
        }
    }
}

private struct EmptyTicketsView: View {
    var body: some View {
        VStack {
            Text("Вариантов нет")
                .font(.bold24)
                .foregroundStyle(.blackApp)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 231)
        }
    }
}

private struct TicketButton: View {
    let ticket: Route
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            TicketCell(ticket: ticket)
        }
    }
}

private struct FilterButton: View {
    @ObservedObject var coordinator: NavCoordinator
    @ObservedObject var viewModel: TicketListViewModel
    
    var body: some View {
        Button(action: {
            coordinator.path.append(RouteEnum.filters)
        }) {
            HStack(spacing: 4) {
                Text("Уточнить время")
                    .font(.bold17)
                    .foregroundStyle(.whiteUni)
                
                if !viewModel.filters.isEmpty {
                    Circle()
                        .foregroundStyle(.redUni)
                        .frame(width: 8, height: 8)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
        }
        .background(.blueUni)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

private struct BackButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(.chevronLeft)
                .renderingMode(.template)
                .foregroundStyle(.blackApp)
        }
    }
}
