//
//  StoriesViewModel.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 01.07.2025.
//

import Foundation

@Observable final class StoriesViewModel: ObservableObject {
    var stories: [Story]
    
    init() {
        self.stories = [
            Story.story1,
            Story.story2,
            Story.story3,
            Story.story4,
            Story.story5,
            Story.story6,
            Story.story7,
            Story.story8,
            Story.story9,
        ]
    }
}
