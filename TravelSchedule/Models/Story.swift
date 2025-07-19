
import Foundation

struct Story: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String
    let imagePrev:  String
    let imageName: String
    
    static let story1 = Story(
        title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text ",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text ",
        imagePrev: "story_preview_1",
        imageName: "story_1")
    
    static let story2 = Story(
        title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text ",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text ",
        imagePrev: "story_preview_2",
        imageName: "story_2")
    
    static let story3 = Story(
        title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text ",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text ",
        imagePrev: "story_preview_3",
        imageName: "story_3")
    
    static let story4 = Story(
        title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text ",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text ",
        imagePrev: "story_preview_4",
        imageName: "story_4")
    
    static let story5 = Story(
        title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text ",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text ",
        imagePrev: "story_preview_5",
        imageName: "story_5")
    
    static let story6 = Story(
        title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text ",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text ",
        imagePrev: "story_preview_6",
        imageName: "story_6")
    
    static let story7 = Story(
        title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text ",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text ",
        imagePrev: "story_preview_7",
        imageName: "story_7")
    
    static let story8 = Story(
        title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text ",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text ",
        imagePrev: "story_preview_8",
        imageName: "story_8")
    
    static let story9 = Story(
        title: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text ",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text ",
        imagePrev: "story_preview_9",
        imageName: "story_9")
}
