//
//  CarrierInfoView.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 02.07.2025.
//

import SwiftUI


struct CarrierInfoView: View {
    @Environment(\.dismiss) var dismiss
    
    let carrier: TicketModel
    
    var body: some View {
        ZStack {
            Color.whiteApp
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Image(.mockCarrierLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 343)
                
                Text(carrier.operatorName)
                    .font(.bold24)
                    .padding(.vertical, 16)
                    .foregroundColor(.blackApp)
                
                VStack(alignment: .leading, spacing: 24) {
                    CarrierLinkView(linkTitle: "E-mail", linkText: "solodovnikov-artem@inbox.ru", linkUrl: "mailto:solodovnikov-artem@inbox.ru")
                    
                    CarrierLinkView(linkTitle: "Телефон", linkText: "+7 (911) 123-45-67", linkUrl: "tel:+79111234567")
                }
                Spacer()
            }
            .padding(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(.chevronLeft)
                            .renderingMode(.template)
                            .foregroundStyle(.blackApp)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Информация о перевозчике")
                        .font(.bold17)
                        .foregroundStyle(.blackApp)
                }
            }
        }
    }
}

#Preview {
    CarrierInfoView(carrier: TicketModel.init(operatorName: "ОАО «РЖД»", date: "14 января", departure: "22:30", arrival: "08:15", duration: "20 часов", withTransfer: true, operatorLogo: "mock_RJD", note: "С пересадкой в Костроме"))
}
