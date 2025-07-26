//
//  TicketCEll.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 02.07.2025.
//

import SwiftUI

struct TicketCell: View {
    let ticket: Route
    
    private var formattedDate: String {
        DateFormatterProvider.shared.dateFormatter.string(from: ticket.date)
    }
    
    private func formattedTime(from date: Date) -> String {
        DateFormatterProvider.shared.timeFormatter.string(from: date)
    }
    
    private var formattedDuration: String {
        let hours = ticket.durationSeconds / 3600
        let minutes = (ticket.durationSeconds % 3600) / 60
        
        if hours >= 1 {
            let hourWord = timeNoun(hours, one: "час", few: "часа", many: "часов")
            return "\(hours) \(hourWord)"
        } else {
            let minuteWord = timeNoun(minutes, one: "минута", few: "минуты", many: "минут")
            return "\(minutes) \(minuteWord)"
        }
    }
    
    private func timeNoun(_ number: Int, one: String, few: String, many: String) -> String {
        let lastTwoDigits = number % 100
        let lastDigit = number % 10
        
        if (11...14).contains(lastTwoDigits) {
            return many
        }
        
        switch lastDigit {
        case 1:
            return one
        case 2, 3, 4:
            return few
        default:
            return many
        }
    }

    var body: some View {
        
        let url = URL(string: ticket.carrier.logoURL)
        
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center) {
                AsyncImage(
                    url: url,
                    transaction: Transaction(animation: .easeInOut)
                ) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 38)
                            .transition(.scale(scale: 0.1, anchor: .leading))
                    case .failure:
                        Image(systemName: "wifi.slash")
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 38, height: 38)
                .background(.whiteUni)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(ticket.carrier.title)
                        .font(.regular17)
                        .foregroundStyle(.blackUni)
                    if let note = ticket.transferPoint {
                        Text("С пересадкой в \(note)")
                            .font(.regular17)
                            .foregroundStyle(.redUni)
                    }
                }
                Spacer()
                Text(formattedDate)
                    .font(.regular12)
                    .foregroundStyle(.blackUni)
            }
            .padding(.bottom, 15)
            HStack {
                Text(formattedTime(from: ticket.departure))
                    .font(.regular17)
                    .foregroundStyle(.blackUni)
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.grayUni)
                Text(formattedDuration)
                    .font(.regular12)
                    .foregroundStyle(.blackUni)
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.grayUni)
                Text(formattedTime(from: ticket.arrival))
                    .font(.regular17)
                    .foregroundStyle(.blackUni)
            }
        }
        .padding()
        .background(.lightGray)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}
