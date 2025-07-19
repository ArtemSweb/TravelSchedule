//
//  StoryView.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 15.07.2025.
//

import SwiftUI

struct StoryView: View {
    let story: Story
    
    var body: some View {
        ZStack {
            Color.blackUni
                .ignoresSafeArea()
            
            Image(story.imageName)
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .overlay(
                    VStack(alignment: .leading, spacing: 16) {
                        Spacer()
                        
                        Text(story.title)
                            .font(.bold34)
                            .lineLimit(2)
                            .foregroundColor(.whiteUni)
                        
                        Text(story.description)
                            .font(.regular20)
                            .lineLimit(3)
                            .foregroundColor(.whiteUni)
                    }
                    .padding(.init(top: 0, leading: 16, bottom: 40, trailing: 16))
                )
        }
    }
}

#Preview {
    StoryView(story: Story(
        title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text ",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text ",
        imagePrev: "story_preview_9",
        imageName: "story_3"))
}
