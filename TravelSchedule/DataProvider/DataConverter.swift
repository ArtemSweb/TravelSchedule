//
//  DataConverter.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 23.07.2025.
//

import Foundation

struct DataConverter {
    func convertSettlements(from response: StationsList) throws -> [City] {
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
                
                return City(title: title, stations: stations)
            } ?? []
        }
        .sorted { $0.title < $1.title }
    }
}

enum DataConverterError: Error {
    case dataConversionError
}
