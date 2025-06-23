//
//  ViewedStoriesStore.swift
//  travel schedule
//
//  Created by user on 23.06.2025.
//

import Foundation

class ViewedStoriesStore: ObservableObject {
    private let key = "viewedStories"
    
    @Published var viewedIDs: Set<UUID> = []
    
    init() {
        load()
    }
    
    func markAsViewed(_ storyID: UUID) {
        if !viewedIDs.contains(storyID) {
            viewedIDs.insert(storyID)
            save()
        }
    }
    
    func isViewed(_ storyID: UUID) -> Bool {
        return viewedIDs.contains(storyID)
    }
    
    private func save() {
        let array = Array(viewedIDs)
        UserDefaults.standard.set(array, forKey: key)
    }
    
    private func load() {
        if let array = UserDefaults.standard.array(forKey: key) as? [UUID] {
            viewedIDs = Set(array)
        }
    }
}
