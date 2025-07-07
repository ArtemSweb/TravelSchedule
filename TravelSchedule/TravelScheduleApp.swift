//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 29.05.2025.
//

import SwiftUI

@main
struct TravelScheduleApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = true
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
