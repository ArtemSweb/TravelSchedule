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
        ZStack {
            Color.whiteApp
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                SVGImageView(svgURL: URL(string: viewModel.logoURL))
                    .frame(width: 38, height: 38)
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
