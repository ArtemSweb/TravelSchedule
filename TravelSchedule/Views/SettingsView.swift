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
        
        ZStack {
            Color.whiteApp
                .ignoresSafeArea()

            VStack {
                Toggle(isOn: $isDarkMode) {
                    Text("Темная тема")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.blackApp)
                }
                .onAppear {
                    isDarkMode = systemColorScheme == .dark
                }
                .tint(.blueUni)
                .padding(.vertical, 19)
                .padding(.horizontal, 16)
                
                HStack {
                    NavigationLink(destination: UserAgreementView()) {
                        Text("Пользовательское соглашение")
                            .font(.regular17)
                            .foregroundColor(.blackApp)
                        
                        Spacer()
                        
                        Image(.chevronRight)
                            .renderingMode(.template)
                            .foregroundStyle(.blackApp)
                    }
                }
                .padding(.horizontal, 16)
                
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
                    .foregroundStyle(.blackApp)
                }
                .padding(.bottom, 24)
                
                Divider()
                    .frame(height: 3)
            }
            .padding(.top, 24)
        }
    }
}

#Preview {
    SettingsView()
}
