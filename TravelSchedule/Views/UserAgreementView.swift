//
//  UserAgreementView.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 14.07.2025.
//

import SwiftUI
import WebKit

struct UserAgreementView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.whiteApp
                .ignoresSafeArea()
            
            if let url = URL(string: "https://yandex.ru/legal/practicum_offer") {
                WebView(url: url)
                    .navigationBarBackButtonHidden(true)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: { dismiss() }) {
                                Image(.chevronLeft)
                                    .renderingMode(.template)
                                    .foregroundColor(.blackApp)
                            }
                        }
                        
                        ToolbarItem(placement: .principal) {
                            Text("Пользовательское соглашение")
                                .font(.bold17)
                                .foregroundColor(.blackApp)
                        }
                    }
            } else {
                ErrorView(errorType: .connectionError)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    UserAgreementView()
}
