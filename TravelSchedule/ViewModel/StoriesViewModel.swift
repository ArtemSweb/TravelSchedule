//
//  StoriesViewModel.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 01.07.2025.
//

import Foundation

@Observable final class StoriesViewModel: ObservableObject {
    var stories: [Story]
    var showStories = false
    var selectedStoryIndex = 0
    var viewedStories: Set<Int> = []
    var pendingStoryIndex: Int?
    
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
    
    func sortedIndices() -> [Int] {
        stories.indices.sorted { lhs, rhs in
            let isViewedL = viewedStories.contains(lhs)
            let isViewedR = viewedStories.contains(rhs)
            if isViewedL == isViewedR { return lhs < rhs }
            return !isViewedL && isViewedR
        }
    }

    func openStory(at index: Int) {
        selectedStoryIndex = index
        showStories = true
        viewedStories.insert(index)
    }

    func markViewed(_ indices: [Int]) {
        viewedStories.formUnion(indices)
    }
}
