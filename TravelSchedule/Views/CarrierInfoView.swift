//
//  CarrierInfoView.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 02.07.2025.
//

import SwiftUI

struct CarrierInfoView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: CarrierInfoViewModel
    
    var body: some View {
        let url = URL(string: viewModel.logoURL)
        
        ZStack {
            Color.whiteApp
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                ZStack {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 104)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 50, height: 50)
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 104)
                .background(.whiteUni)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(viewModel.title)
                            .font(.bold24)
                            .padding(.vertical, 16)
                            .foregroundColor(.blackApp)
                        
                        VStack(alignment: .leading, spacing: 24) {
                            CarrierLinkView(linkTitle: "E-mail", linkText: viewModel.email, linkUrl: "mailto:\(viewModel.email)")
                            
                            CarrierLinkView(linkTitle: "Телефон", linkText: viewModel.phone, linkUrl: "tel:\(viewModel.phone)")
                        }
                    }
                    Spacer()
                }
                Spacer()

            }
            .padding(.horizontal, 16)
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

//#Preview {
//    CarrierInfoView(carrier: Route(id: "123", date: <#T##Date#>, departure: <#T##Date#>, arrival: <#T##Date#>, durationSeconds: 600, hasTransfers: false, transferPoint: <#T##String?#>, carrier: <#T##Carrier#>))
//}
