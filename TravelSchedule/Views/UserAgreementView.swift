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
    let agreementURL = URL(string: "https://yandex.ru/legal/practicum_offer")!
    
    var body: some View {
        WebView(url: agreementURL)
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
    }
}

#Preview {
    UserAgreementView()
}
