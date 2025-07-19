//
//  StoriesView.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 15.07.2025.
//

import SwiftUI
import Combine

struct StoriesView: View {
    @State private var progress: CGFloat = 0
    @State private var timer: Timer.TimerPublisher
    @State private var cancellable: Cancellable?
    @State private var selection: Int
    @State private var localViewedStories: Set<Int> = []
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Environment(\.dismiss) var dismiss
    
    let onViewed: (Set<Int>) -> Void
    private let stories: [Story]
    private let configuration: TimerConfiguration
    
    init(onViewed: @escaping (Set<Int>) -> Void, stories: [Story], initialIndex: Int) {
        self.onViewed = onViewed
        self.stories = stories
        _selection = State(initialValue: initialIndex)
        configuration = TimerConfiguration(storiesCount: stories.count)
        timer = Self.createTimer(configuration: configuration)
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.blackUni
                .ignoresSafeArea()
            
            TabView(selection: $selection) {
                ForEach(stories.indices, id: \.self) { index in
                    ZStack {
                        StoryView(story: stories[index])
                        HStack {
                            Color.clear
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    if selection > 0 {
                                        selection -= 1
                                        progress = 0
                                        resetTimer()
                                    }
                                }
                            Color.clear
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    goToNextStoryOrDismiss()
                                }
                        }
                    }
                    .tag(index)
                    
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onChange(of: selection) {
                localViewedStories.insert(selection)
                progress = 0
                resetTimer()
            }
            
            ProgressBar(numberOfSections: stories.count, progress: CGFloat(selection) + progress)
                .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
            
            CloseButton(action: {
                dismiss()
            })
                .padding(.top,57)
                .padding(.trailing, 12)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onAppear {
            localViewedStories.insert(selection)
            timer = Self.createTimer(configuration: configuration)
            cancellable = timer.connect()
        }
        .onDisappear {
            cancellable?.cancel()
            onViewed(localViewedStories)
        }
        .onReceive(timer) { _ in
            timerTick()
        }
    }
    
    private func timerTick() {
        var nextProgress = progress + configuration.progressPerTick
        if nextProgress >= 1 {
            goToNextStoryOrDismiss()
        }
        withAnimation {
            progress = nextProgress
        }
    }
    
    private func goToNextStoryOrDismiss() {
        if selection < stories.count - 1 {
            selection += 1
            progress = 0
        } else {
            onViewed(localViewedStories)
            dismiss()
        }
    }
    
    private func resetTimer() {
        cancellable?.cancel()
        timer = Self.createTimer(configuration: configuration)
        cancellable = timer.connect()
    }
    
    private static func createTimer(configuration: TimerConfiguration) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }
}
