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
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = CitiesListViewModel()
    @State private var fetchTask: Task<Void, Never>?
    
    let onSettlementSelected: (Settlement) -> Void
    
    // MARK: - Content
    var body: some View {
        ZStack {
            Color.whiteApp.ignoresSafeArea()
            
            if viewModel.isLoading {
                ProgressView()
            } else if viewModel.loadingFailed {
                VStack {
                    Text("Ошибка")
                }
            } else {
                content
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Private view

    private var content: some View {
        VStack(spacing: .zero) {
            CustomSearchBar(text: $viewModel.searchText, placeholder: "Введите запрос")
            cityList
        }
        .task {
            fetchTask = Task {
                await viewModel.fetchSettlements()
            }
        }
        .padding(.horizontal, 16)
        .scrollIndicators(.hidden)
        .navigationBarBackButtonHidden(true)
        .toolbar { toolbarContent }
    }
    
    private var cityList: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading) {
                if viewModel.filteredSettlements.isEmpty && viewModel.isSearching {
                    emptyState
                } else {
                    ForEach(viewModel.filteredSettlements) { settlement in
                        cityButton(for: settlement)
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    .background(.whiteApp)
                }
            }
        }
    }
    
    private func cityButton(for settlement: Settlement) -> some View {
        Button(action: {
                onSettlementSelected(settlement)
            }) {
            HStack {
                Text(settlement.title)
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

//#Preview {
//    CitiesListView(
//        coordinator: NavCoordinator(),
//        fromField: true
//    )
//}
