//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 01.07.2025.
//


import SwiftUI

struct SettingsView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Environment(\.colorScheme) private var systemColorScheme
    
    var body: some View {
        VStack {
            Toggle(isOn: $isDarkMode) {
                Text("Темная тема")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(Color(.black))
            }
            .onAppear() {
                isDarkMode = (systemColorScheme == .dark)
            }
            .tint(Color(.blueUni))
            .padding(.vertical, 19)
            
            Spacer()
            
            VStack(alignment: .center, spacing: 16) {
                Group {
                    Text("Приложение использует API «Яндекс.Расписания»")
                    
                    Text("Версия 1.0 (beta)")
                }
                    .multilineTextAlignment(.center)
                    .lineSpacing(16)
                    .tracking(0.4)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(Color(.black))

            }
                
            Divider()
                .frame(height: 3)
                .padding(.top, 24)
        }
        .padding(.horizontal, 16)
        .padding(.top, 24)
    }
}

#Preview {
    SettingsView()
}
