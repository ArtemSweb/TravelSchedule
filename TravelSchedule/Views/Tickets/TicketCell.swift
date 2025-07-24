//
//  TicketCEll.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 02.07.2025.
//

import SwiftUI

struct TicketCell: View {
    let ticket: TicketModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                Image(ticket.operatorLogo)
                    .resizable()
                    .frame(width: 38, height: 38)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                VStack(alignment: .leading, spacing: 2) {
                    Text(ticket.operatorName)
                        .font(.regular17)
                        .foregroundStyle(.blackUni)
                    if let note = ticket.note {
                        Text(note)
                            .font(.regular17)
                            .foregroundStyle(.redUni)
                    }
                }
                Spacer()
                Text(ticket.date)
                    .font(.regular12)
                    .foregroundStyle(.blackUni)
            }
            .padding(.bottom, 5)
            HStack {
                Text(ticket.departure)
                    .font(.regular17)
                    .foregroundStyle(.blackUni)
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.grayUni)
                Text(ticket.duration)
                    .font(.regular12)
                    .foregroundStyle(.blackUni)
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.grayUni)
                Text(ticket.arrival)
                    .font(.regular17)
                    .foregroundStyle(.blackUni)
            }
        }
        .padding()
        .background(.lightGray)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}
