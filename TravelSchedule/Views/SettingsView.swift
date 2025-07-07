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
    
    //Для проверки экранов ошибок
    var isServerError = false
    var isInternetError = false
    
    var body: some View {
        if isServerError {
            ServerErrorView()
        } else if isInternetError {
            InternetErrorView()
        } else {
            
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
            
            HStack {
                NavigationLink(destination: ServerErrorView()) {
                    Text("Экран ошибки сервера")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.blackApp)
                    
                    Spacer()
                    
                    Image(.chevronRight)
                        .renderingMode(.template)
                        .foregroundStyle(.blackApp)
                }
                .padding(.vertical, 19)
            }
            HStack {
                NavigationLink(destination: InternetErrorView()) {
                    Text("Экран ошибки интернета")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.blackApp)
                    
                    Spacer()
                    
                    Image(.chevronRight)
                        .renderingMode(.template)
                        .foregroundStyle(.blackApp)
                }
                .padding(.vertical, 19)
            }
            
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
                
            Divider()
                .frame(height: 3)
                .padding(.top, 24)
        }
        .padding(.horizontal, 16)
        .padding(.top, 24)
    }
    }
}

#Preview {
    SettingsView()
}
