//
//  MaskFragmentView.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 15.07.2025.
//

import SwiftUI

struct MaskFragmentView: View {
    var body: some View {
        Rectangle()
            .fixedSize(horizontal: false, vertical: true)
            .frame(height: .progressBarHeight)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: .progressBarCornerRadius))
    }
}

#Preview {
    Color.appGrey
        .ignoresSafeArea()
        .overlay(
            HStack {
                MaskFragmentView()
                MaskFragmentView()
                MaskFragmentView()
            }.padding()
        )
}
