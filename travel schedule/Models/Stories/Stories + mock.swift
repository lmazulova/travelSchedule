//
//  Stories.swift
//  travel schedule
//
//  Created by user on 23.06.2025.
//

import SwiftUI

struct Stories: Identifiable {
    let id: UUID
    let storiesScreens: [StoriesScreen]
    
    init(id: UUID = UUID(), storiesScreens: [StoriesScreen]) {
        self.storiesScreens = storiesScreens
        self.id = id
    }
}

//MARK: - MockData
extension Stories {
    static let stories1: Stories = Stories(
        id: UUID(uuidString: "A1B2C3D4-E5F6-7890-1234-56789ABCDEF0")!,
        storiesScreens: [
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("firstImage1")),
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("secondImage1")),
    ])
    static let stories2: Stories = Stories(
        id: UUID(uuidString: "B1C2D3E4-F5A6-7890-1234-56789ABCDEF1")!,
        storiesScreens: [
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("firstImage2")),
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("secondImage2")),
    ])
    static let stories3: Stories = Stories(
        id: UUID(uuidString: "C1D2E3F4-A5B6-7890-1234-56789ABCDEF2")!,
        storiesScreens: [
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("firstImage3")),
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("secondImage3")),
    ])
    static let stories4: Stories = Stories(
        id: UUID(uuidString: "D1E2F3A4-B5C6-7890-1234-56789ABCDEF3")!,
        storiesScreens: [
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("firstImage4")),
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("secondImage4")),
    ])
    static let stories5: Stories = Stories(
        id: UUID(uuidString: "E1F2A3B4-C5D6-7890-1234-56789ABCDEF4")!,
        storiesScreens: [
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("firstImage5")),
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("secondImage5")),
    ])
    static let stories6: Stories = Stories(
        id: UUID(uuidString: "F1A2B3C4-D5E6-7890-1234-56789ABCDEF5")!,
        storiesScreens: [
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("firstImage6")),
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("secondImage6")),
    ])
    static let stories7: Stories = Stories(
        id: UUID(uuidString: "F1A2B3C4-D5E6-7890-1234-56789ABCDEF6")!,
        storiesScreens: [
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("firstImage7")),
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("secondImage7")),
    ])
    static let stories8: Stories = Stories(
        id: UUID(uuidString: "F1A2B3C4-D5E6-7890-1234-56789ABCDEF7")!,
        storiesScreens: [
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("firstImage8")),
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("secondImage8")),
    ])
    static let stories9: Stories = Stories(
        id: UUID(uuidString: "F1A2B3C4-D5E6-7890-1234-56789ABCDEF8")!,
        storiesScreens: [
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("firstImage9")),
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("secondImage9")),
    ])
    
}
