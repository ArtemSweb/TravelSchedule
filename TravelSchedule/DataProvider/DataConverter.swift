//
//  DataConverter.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 23.07.2025.
//

import Foundation

struct DataConverter {
    func convertSettlements(from response: StationsList) throws -> [Settlement] {
        guard let countries = response.countries,
              let country = countries.first(where: { $0.title == "Россия" }),
              let regions = country.regions else {
            throw DataConverterError.dataConversionError
        }
        
        return regions.flatMap { region in
            region.settlements?.compactMap { stationSettlement in
                guard let title = stationSettlement.title,
                      !title.isEmpty else { return nil }
                
                let stations = stationSettlement.stations?
                    .filter { $0.station_type == "airport" || $0.station_type == "train_station" }
                    .map { Station(title: $0.title ?? "", code: $0.codes?.yandex_code ?? "") } ?? []
                    .sorted { $0.title < $1.title }
                guard !stations.isEmpty else { return nil }
                
                return Settlement(title: title, stations: stations)
            } ?? []
        }
        .sorted { $0.title < $1.title }
    }
    
    func convertRoutes(from response: ScheduleBetweenStations) throws -> [Route] {
        guard let segments = response.segments else {
            throw DataConverterError.dataConversionError
        }
        
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate, .withDashSeparatorInDate, .withTime, .withColonSeparatorInTime]
        
        return try! segments.compactMap { segment in
            guard
                let startDateString = segment.start_date,
                let departureTimeString = segment.departure,
                let arrivalTimeString = segment.arrival,
                let durationSeconds = segment.duration,
                let carrierData = segment.thread?.carrier
            else {
                throw DataConverterError.dataConversionError
            }
            
            let departureDateString = "\(startDateString)T\(departureTimeString)"
            let arrivalDateString = "\(startDateString)T\(arrivalTimeString)"
            
            guard
                let departure = dateFormatter.date(from: departureDateString),
                let arrival = dateFormatter.date(from: arrivalDateString),
                let date = dateFormatter.date(from: "\(startDateString)T00:00:00")
            else {
                throw DataConverterError.dataConversionError
            }
            
            let carrier = Carrier(
                code: String(carrierData.code ?? 0),
                title: carrierData.title ?? "",
                logoSVG: carrierData.logo_svg ?? "",
                logoFull: carrierData.logo ?? "",
                email: carrierData.email?.isEmpty == false ? carrierData.email : nil,
                phone: carrierData.phone?.isEmpty == false ? carrierData.phone : nil
            )
            
            return Route(
                date: date,
                departure: departure,
                arrival: arrival,
                durationSeconds: Int(durationSeconds),
                hasTransfers: segment.has_transfers ?? false,
                transferPoint: nil,
                carrier: carrier
            )
        }
        .sorted { $0.departure < $1.departure }
    }
}

enum DataConverterError: Error {
    case dataConversionError
}
