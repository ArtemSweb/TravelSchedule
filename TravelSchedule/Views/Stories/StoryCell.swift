//
//  StoryCell.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 01.07.2025.
//

import SwiftUI

struct StoryCell: View {
    var story: Story
    let isViewed: Bool

    
    var body: some View {
        let storyHeight: Double = 140
        let storyWidth: Double = 92

        ZStack {
            Image(story.imagePrev)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .frame(width: storyWidth, height: storyHeight)
                .opacity(isViewed ? 0.5 : 1.0)
            if !isViewed {
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(.blueUni, lineWidth: 4)
                    .frame(width: storyWidth, height: storyHeight)
            }
        }
        .overlay {
            VStack {
                Spacer()
                Text(story.title)
                    .font(.regular12)
                    .foregroundColor(.whiteUni)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .padding(.init(top: 0, leading: 8, bottom: 12, trailing: 8))
            }
        }
    }
}

#Preview {
    let mockStory = Story(
        title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text ",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text ",
        imagePrev: "story_preview_3",
        imageName: "story_3")
    StoryCell(story: mockStory, isViewed: false)
}
