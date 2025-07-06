//
//  TicketModel.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 01.07.2025.
//

import SwiftUI

struct TicketModel: Hashable, Identifiable {
    let id = UUID()
    let operatorName: String
    let date: String
    let departure: String
    let arrival: String
    let duration: String
    let withTransfer: Bool
    let operatorLogo: String
    let note: String?
}
