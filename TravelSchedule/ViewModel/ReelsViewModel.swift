//
//  ReelsViewModel.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 01.07.2025.
//

import Foundation

@Observable final class ReelsViewModel: ObservableObject {
    var reels: [ReelsModel]
    
    init() {
        let reels1 = ReelsModel(imageName: "mock_preview_1")
        let reels2 = ReelsModel(imageName: "mock_preview_2")
        let reels3 = ReelsModel(imageName: "mock_preview_3")
        let reels4 = ReelsModel(imageName: "mock_preview_4")
        let reels5 = ReelsModel(imageName: "mock_preview_5")
        let reels6 = ReelsModel(imageName: "mock_preview_6")
        let reels7 = ReelsModel(imageName: "mock_preview_7")
        let reels8 = ReelsModel(imageName: "mock_preview_8")
        let reels9 = ReelsModel(imageName: "mock_preview_9")
        
        self.reels = [reels1, reels2, reels3, reels4, reels5, reels6, reels7, reels8, reels9]
    }
}
