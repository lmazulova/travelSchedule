//
//  StoriesView.swift
//  travel schedule
//
//  Created by user on 24.06.2025.
//

import SwiftUI

struct StoriesView: View {
    let stories: [StoriesScreen]
    private var timerConfiguration: TimerConfiguration { .init(storiesCount: stories.count) }
    @State var currentStoryIndex: Int = 0
    @State var currentProgress: CGFloat = 0
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoriesTabView(stories: stories, currentStoryIndex: $currentStoryIndex)
                .onChange(of: currentStoryIndex) { oldValue, newValue in
                    didChangeCurrentIndex(oldIndex: oldValue, newIndex: newValue)
                }

            StoriesProgressBar(
                storiesCount: stories.count,
                timerConfiguration: timerConfiguration,
                currentProgress: $currentProgress
            )
            .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
            .onChange(of: currentProgress) { _, newValue in
                didChangeCurrentProgress(newProgress: newValue)
            }
            
            Button(action: { dismiss() }) {
                Image("close")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .padding(.top, 50)
                    .padding(.trailing, 12)
            }
        }
    }

    private func didChangeCurrentIndex(oldIndex: Int, newIndex: Int) {
        guard oldIndex != newIndex else { return }
        let progress = timerConfiguration.progress(for: newIndex)
        guard abs(progress - currentProgress) >= 0.01 else { return }
        withAnimation {
            currentProgress = progress
        }
    }

    private func didChangeCurrentProgress(newProgress: CGFloat) {
        if newProgress >= 1.0 {
            dismiss()
            return
        }
        let index = timerConfiguration.index(for: newProgress)
        guard index != currentStoryIndex else { return }
        withAnimation {
            currentStoryIndex = index
        }
    }
}
