//
//  Extension+Stories.swift
//  travel schedule
//
//  Created by user on 28.06.2025.
//

import SwiftUI

//MARK: - Mock stories data
extension Story {
    static func mock(id: UUID = UUID(), imageNames: [String]) -> Story {
        Story(
            id: id,
            storiesScreens: imageNames.map {
                StoryScreen(
                    title: "Sample Story",
                    description: "This is a sample story description for view.",
                    image: Image($0)
                )
            }
        )
    }
    
    static let story1: Story = mock(id: UUID(uuidString: "A1B2C3D4-E5F6-7890-1234-56789ABCDEF0")!, imageNames: ["firstImage1", "secondImage1"])
    
    static let story2: Story = mock(id: UUID(uuidString: "B1C2D3E4-F5A6-7890-1234-56789ABCDEF1")!, imageNames: ["firstImage2", "secondImage2"])

    static let story3: Story = mock(id: UUID(uuidString: "C1D2E3F4-A5B6-7890-1234-56789ABCDEF2")!, imageNames: ["firstImage3", "secondImage3"])
    
    static let story4: Story = mock(id: UUID(uuidString: "D1E2F3A4-B5C6-7890-1234-56789ABCDEF3")!, imageNames: ["firstImage4", "secondImage4"])

    static let story5: Story = mock(id: UUID(uuidString: "E1F2A3B4-C5D6-7890-1234-56789ABCDEF4")!, imageNames: ["firstImage5", "secondImage5"])
    
    static let story6: Story = mock(id: UUID(uuidString: "F1A2B3C4-D5E6-7890-1234-56789ABCDEF5")!, imageNames: ["firstImage6", "secondImage6"])
    
    static let story7: Story = mock(id: UUID(uuidString: "F1A2B3C4-D5E6-7890-1234-56789ABCDEF6")!, imageNames: ["firstImage7", "secondImage7"])
    
    static let story8: Story = mock(id: UUID(uuidString: "F1A2B3C4-D5E6-7890-1234-56789ABCDEF7")!, imageNames: ["firstImage8", "secondImage8"])
    
    static let story9: Story = mock(id: UUID(uuidString: "F1A2B3C4-D5E6-7890-1234-56789ABCDEF8")!, imageNames: ["firstImage9", "secondImage9"])
}
