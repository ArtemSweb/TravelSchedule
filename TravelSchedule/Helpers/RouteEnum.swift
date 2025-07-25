//
//  RouteEnum.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 01.07.2025.
//
import Foundation

enum RouteEnum: Hashable {
    case cityPicker(fromField: Bool)
    case stationPicker(settlement: Settlement, fromField: Bool)
    case tickets(settlementFrom: Settlement, stationFrom: Station, settlementTo: Settlement, stationTo: Station)
    case filters
    case carrierInfo(TicketModel)
}
