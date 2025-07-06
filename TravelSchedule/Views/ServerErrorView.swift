//
//  ServerErrorView.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 06.07.2025.
//

import SwiftUI

struct ServerErrorView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Image("server_error")
                .resizable()
                .frame(width: 223, height: 223)
                .clipShape(RoundedRectangle(cornerRadius: 70))
            
            Text("Ошибка сервера")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.black)
        }
        
    }
}

#Preview {
    ServerErrorView()
}
