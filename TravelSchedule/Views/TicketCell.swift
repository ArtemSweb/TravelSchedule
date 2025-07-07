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
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.blackUni)
                    if let note = ticket.note {
                        Text(note)
                            .font(.system(size: 17, weight: .regular))
                            .foregroundStyle(.redUni)
                    }
                }
                Spacer()
                Text(ticket.date)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.blackUni)
            }
            .padding(.bottom, 5)
            HStack {
                Text(ticket.departure)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.blackUni)
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.grayUni)
                Text(ticket.duration)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.blackUni)
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.grayUni)
                Text(ticket.arrival)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.blackUni)
            }
        }
        .padding()
        .background(.lightGray)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}
