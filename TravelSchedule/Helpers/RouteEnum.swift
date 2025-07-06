//
//  RouteEnum.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 01.07.2025.
//
import Foundation

enum RouteEnum: Hashable {
    case cityPicker(fromField: Bool)
    case stationPicker(city: String, fromField: Bool)
    case tickets
    case filters
    case carrierInfo(TicketModel)
}
