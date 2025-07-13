//
//  InternetErrorView.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 06.07.2025.
//

import SwiftUI

struct InternetErrorView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Image("internet_error")
                .resizable()
                .frame(width: 223, height: 223)
                .clipShape(RoundedRectangle(cornerRadius: 70))
            
            Text("Нет интернета")
                .font(.bold24)
                .foregroundStyle(.blackApp)
        }
    }
}

#Preview {
    InternetErrorView()
}
