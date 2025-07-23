//
//  SettingsViewModel.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 20.07.2025.
//
import SwiftUI

@Observable
final class SettingsViewModel {
    
    static let shared = SettingsViewModel()
    
    var isDarkMode: Bool {
            didSet {
                UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
                hasUserChangedTheme = true
            }
        }
        private var hasUserChangedTheme: Bool = false
        
        private init() {
            let legacyValue = UserDefaults.standard.object(forKey: "isDarkMode") as? Bool
            let systemIsDark = UITraitCollection.current.userInterfaceStyle == .dark
            self.isDarkMode = legacyValue ?? systemIsDark
            self.hasUserChangedTheme = (legacyValue != nil)
        }
        
        func updateWithSystemTheme(_ systemIsDark: Bool) {
            if !hasUserChangedTheme {
                isDarkMode = systemIsDark
            }
        }
}
