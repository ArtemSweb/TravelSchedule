//
//  CarrierLinkView.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 14.07.2025.
//

import SwiftUI

struct CarrierLinkView: View {
    
    let linkTitle: String
    let linkText: String
    let linkUrl: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(linkTitle)
                .font(.regular17)
                .foregroundColor(.blackApp)
            
            if let url = URL(string: linkText) {
                Link(linkText, destination: url)
                    .font(.regular12)
                    .foregroundColor(.blueUni)
            } else {
                Text(linkText)
                    .font(.regular12)
                    .foregroundColor(.blueUni)
            }
            
        }
    }
}

#Preview {
    CarrierLinkView(linkTitle: "E-mail", linkText: "solodovnikov-artem@inbox.ru", linkUrl: "mailto:solodovnikov-artem@inbox.ru")
}
