//
//  CarrierInfoViewModel.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 26.07.2025.
//

import Foundation

@MainActor
final class CarrierInfoViewModel: ObservableObject {
    private let carrier: Route
    
    init(carrier: Route) {
        self.carrier = carrier
    }
    
    var title: String {
        carrier.carrier.title
    }
    
    var logoURL: String {
        carrier.carrier.logoSVG.isEmpty  ? carrier.carrier.logoFull : carrier.carrier.logoSVG
    }
    
    var email: String {
        carrier.carrier.email ?? "Не указан"
    }
    
    var phone: String {
        carrier.carrier.phone ?? "Не указан"
    }
}
