//
//  TimerConfiguration.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 15.07.2025.
//

import Foundation

struct TimerConfiguration {
    let timerTickInternal: TimeInterval
    let progressPerTick: CGFloat
    
    init(
        storiesCount: Int,
        secondsPerStory: TimeInterval = 5,
        timerTickInternal: TimeInterval = 0.05
    ) {
        self.timerTickInternal = timerTickInternal
        self.progressPerTick = 1.0 / secondsPerStory * timerTickInternal
    }
}
