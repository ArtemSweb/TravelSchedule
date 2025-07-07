//
//  PeriodicEnum.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 01.07.2025.
//

enum PeriodicEnum: String, CaseIterable, Hashable {
    case morning = "Утро 06:00 - 12:00"
    case day = "День 12:00 - 18:00"
    case evening = "Вечер 18:00 - 00:00"
    case night = "Ночь 00:00 - 06:00"
}
