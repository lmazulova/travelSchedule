//
//  Story.swift
//  travel schedule
//
//  Created by user on 22.06.2025.
//

import SwiftUI

struct Story: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let image: Image
    
    init(title: String, description: String, image: Image) {
        self.title = title
        self.description = description
        self.image = image
    }
}
