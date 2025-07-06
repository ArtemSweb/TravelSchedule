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
        VStack() {
//            место для элементов экрана Информация о перевозчике
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(.chevronLeft)
                        .renderingMode(.template)
                        .foregroundStyle(.white)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("Информация о перевозчике")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(.white)
            }
        }
    }
}
