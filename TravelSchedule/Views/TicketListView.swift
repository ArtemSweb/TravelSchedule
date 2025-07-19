//
//  TicketListView.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 01.07.2025.
//


import SwiftUI

struct TicketListView: View {
    @ObservedObject var coordinator: NavCoordinator
    @Environment(\.dismiss) var dismiss
    
    let tickets: [TicketModel] = [
        .init(operatorName: "ОАО «РЖД»", date: "14 января", departure: "22:30", arrival: "08:15", duration: "20 часов", withTransfer: true, operatorLogo: "mock_RJD", note: "С пересадкой в Костроме"),
        .init(operatorName: "ФГК", date: "15 января", departure: "01:15", arrival: "09:00", duration: "9 часов", withTransfer: false, operatorLogo: "mock_FGK", note: nil),
        .init(operatorName: "Урал логистика", date: "16 января", departure: "12:30", arrival: "21:00", duration: "9 часов", withTransfer: false, operatorLogo: "mock_URAL", note: nil),
        .init(operatorName: "РЖД", date: "17 января", departure: "22:30", arrival: "08:15", duration: "20 часов", withTransfer: true, operatorLogo: "mock_RJD", note: "С пересадкой в Костроме"),
        .init(operatorName: "РЖД", date: "17 января", departure: "22:30", arrival: "08:15", duration: "20 часов", withTransfer: false, operatorLogo: "mock_RJD", note: nil),
        .init(operatorName: "РЖД", date: "17 января", departure: "22:30", arrival: "08:15", duration: "20 часов", withTransfer: false, operatorLogo: "mock_RJD", note: nil),
        .init(operatorName: "РЖД", date: "17 января", departure: "22:30", arrival: "08:15", duration: "20 часов", withTransfer: false, operatorLogo: "mock_RJD", note: nil)
    ]
    
    private var filteredTickets: [TicketModel] {
        tickets.filter { ticket in
            // Фильтр по пересадкам
            if let show = coordinator.showTransfers, show != ticket.withTransfer {
                return false
            }
            
            // Фильтр по времени
            guard coordinator.timeFilters.isEmpty else {
                return coordinator.timeFilters.contains(ticket.departurePeriod)
            }
            
            return true
        }
    }
    
    private var routeTitle: String {
        "\(coordinator.selectedCityFrom) (\(coordinator.selectedStationFrom)) → \(coordinator.selectedCityTo) (\(coordinator.selectedStationTo))"
    }
    
    var body: some View {
        ZStack {
            Color.whiteApp
                .ignoresSafeArea()
            VStack(spacing: 16) {
                RouteHeaderView(title: routeTitle)
                
                ZStack(alignment: .bottom) {
                    TicketsScrollView(tickets: filteredTickets, coordinator: coordinator)
                    
                    FilterButton(coordinator: coordinator)
                        .padding(.bottom, 24)
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
    let tickets: [TicketModel]
    let coordinator: NavCoordinator
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                if tickets.isEmpty {
                    EmptyTicketsView()
                } else {
                    ForEach(tickets) { ticket in
                        TicketButton(ticket: ticket, action: {
                            coordinator.path.append(RouteEnum.carrierInfo(ticket))
                        })
                    }
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
    let ticket: TicketModel
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            TicketCell(ticket: ticket)
        }
    }
}

private struct FilterButton: View {
    @ObservedObject var coordinator: NavCoordinator
    
    var body: some View {
        Button(action: {
            coordinator.path.append(RouteEnum.filters)
        }) {
            HStack(spacing: 4) {
                Text("Уточнить время")
                    .font(.bold17)
                    .foregroundStyle(.whiteUni)
                
                if coordinator.isFiltersValid {
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

// MARK: - Extensions

extension TicketModel {
    var departurePeriod: PeriodicEnum {
        let depHour = Int(departure.prefix(2)) ?? 0
        switch depHour {
        case 6..<12: return .morning
        case 12..<18: return .day
        case 18..<24: return .evening
        default: return .night
        }
    }
}
