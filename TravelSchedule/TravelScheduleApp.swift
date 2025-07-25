//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 29.05.2025.
//

import SwiftUI
import SDWebImageSVGKitPlugin

@main
struct TravelScheduleApp: App {
    @State private var viewModel = SettingsViewModel.shared
    
    init() {
        SDImageCodersManager.shared.addCoder(SDImageSVGKCoder.shared)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(viewModel.isDarkMode ? .dark : .light)
                .onAppear {
                    let systemIsDark = UITraitCollection.current.userInterfaceStyle == .dark
                    viewModel.updateWithSystemTheme(systemIsDark)
                }
        }
    }
}
