//
//  Stories.swift
//  travel schedule
//
//  Created by user on 23.06.2025.
//

import SwiftUI

struct Story: Identifiable {
    let id: UUID
    let storiesScreens: [StoryScreen]
    
    init(id: UUID = UUID(), storiesScreens: [StoryScreen]) {
        self.storiesScreens = storiesScreens
        self.id = id
    }
}
