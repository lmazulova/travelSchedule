//
//  StoriesProgressBar.swift
//  travel schedule
//
//  Created by user on 23.06.2025.
//

import SwiftUI
import Combine

struct StoriesProgressBar: View {
    let storiesCount: Int
    let timerConfiguration: TimerConfiguration
    @Binding var currentProgress: CGFloat
    @State private var timer: Timer.TimerPublisher
    @State private var cancellable: Cancellable?

    init(storiesCount: Int, timerConfiguration: TimerConfiguration, currentProgress: Binding<CGFloat>) {
        self.storiesCount = storiesCount
        self.timerConfiguration = timerConfiguration
        self._currentProgress = currentProgress
        self.timer = Self.makeTimer(configuration: timerConfiguration)
    }

    var body: some View {
        ProgressBar(numberOfSections: storiesCount, progress: currentProgress)
            .padding(.init(top: 7, leading: 12, bottom: 12, trailing: 12))
            .onAppear {
                timer = Self.makeTimer(configuration: timerConfiguration)
                cancellable = timer.connect()
            }
            .onDisappear {
                cancellable?.cancel()
            }
            .onReceive(timer) { _ in
                timerTick()
            }
    }

    private func timerTick() {
        withAnimation {
            currentProgress = timerConfiguration.nextProgress(progress: currentProgress)
        }
    }
}

extension StoriesProgressBar {
    private static func makeTimer(configuration: TimerConfiguration) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }
}


#Preview {
    struct StoriesProgressBarPreviewWrapper: View {
        @State private var progress: CGFloat = 0.0
        
        var body: some View {
            StoriesProgressBar(
                storiesCount: 5,
                timerConfiguration: TimerConfiguration(storiesCount: 5, secondsPerStory: 5, timerTickInternal: 0.5),
                currentProgress: $progress
            )
            .frame(height: 20)
            .background(Color.gray.opacity(0.2))
        }
    }
    
    return StoriesProgressBarPreviewWrapper()
}
