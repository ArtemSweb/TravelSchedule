//
//  ProgressBar.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 15.07.2025.
//

import SwiftUI

struct ProgressBar: View {
    let numberOfSections: Int
    let progress: CGFloat
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<numberOfSections, id: \.self) { index in
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        MaskFragmentView()
                        
                        // Синяя полоска текущего прогресса
                        Rectangle()
                            .frame(width: geometry.size.width * fillFor(index: index), height: .progressBarHeight)
                            .foregroundColor(.blueUni)
                            .clipShape(RoundedRectangle(cornerRadius: .progressBarCornerRadius))
                    }
                }
                .frame(height: .progressBarHeight)
            }
        }
    }
    
    private func fillFor(index: Int) -> CGFloat {
        if progress >= CGFloat(index + 1) { return 1 }
        else if progress > CGFloat(index) { return progress - CGFloat(index) }
        else { return 0 }
    }
}

#Preview {
    Color.gray
        .ignoresSafeArea()
        .overlay(
            ProgressBar(numberOfSections: 4, progress: 1.3)
                .padding()
        )
}
