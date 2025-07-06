//
//  ReelsCell.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 01.07.2025.
//

import SwiftUI

struct ReelsCell: View {
    var reels: ReelsModel
    
    var body: some View {
        let reelsHeight: Double = 140
        let reelsWidth: Double = 92
        
        ZStack {
            Image(reels.imageName)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .frame(width: reelsWidth, height: reelsHeight)
            
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color(.blueUni), lineWidth: 4)
                .frame(width: reelsWidth, height: reelsHeight)
        }
    }
}

#Preview {
    let mockReels = ReelsModel(imageName: "mock_preview_1")
    return ReelsCell(reels: mockReels)
        .padding()
        .background(Color(.systemBackground))
}
