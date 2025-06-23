//
//  Stories.swift
//  travel schedule
//
//  Created by user on 23.06.2025.
//

import SwiftUI

struct Stories: Identifiable {
    let id = UUID()
    let storiesScreens: [StoriesScreen]
    private var storiesCount: Int { storiesScreens.count }
    
    init(storiesScreens: [StoriesScreen]) {
        self.storiesScreens = storiesScreens
    }
}

//MARK: - MockData
extension Stories {
    static let stories1: Stories = Stories(storiesScreens: [
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("firstImage1")),
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("secondImage1")),
    ])
    static let stories2: Stories = Stories(storiesScreens: [
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("firstImage2")),
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("secondImage2")),
    ])
    static let stories3: Stories = Stories(storiesScreens: [
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("firstImage3")),
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("secondImage3")),
    ])
    static let stories4: Stories = Stories(storiesScreens: [
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("firstImage4")),
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("secondImage4")),
    ])
    static let stories5: Stories = Stories(storiesScreens: [
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("firstImage5")),
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("secondImage5")),
    ])
    static let stories6: Stories = Stories(storiesScreens: [
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("firstImage6")),
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("secondImage6")),
    ])
    static let stories7: Stories = Stories(storiesScreens: [
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("firstImage7")),
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("secondImage7")),
    ])
    static let stories8: Stories = Stories(storiesScreens: [
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("firstImage8")),
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("secondImage8")),
    ])
    static let stories9: Stories = Stories(storiesScreens: [
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("firstImage9")),
        StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("secondImage9")),
    ])
    
}
