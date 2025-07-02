//
//  HalfScreenTapGesture.swift
//  travel schedule
//
//  Created by user on 24.06.2025.
//

import SwiftUI

struct HalfScreenTapGesture: UIViewRepresentable {
    var onLeftTap: () -> Void
    var onRightTap: () -> Void
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let tap = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:)))
        view.addGestureRecognizer(tap)
        let swipeLeft = UISwipeGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleSwipeLeft(_:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleSwipeRight(_:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onLeftTap: onLeftTap, onRightTap: onRightTap)
    }
    
    final class Coordinator: NSObject {
        let onLeftTap: () -> Void
        let onRightTap: () -> Void
        
        init(onLeftTap: @escaping () -> Void, onRightTap: @escaping () -> Void) {
            self.onLeftTap = onLeftTap
            self.onRightTap = onRightTap
        }
        
        @MainActor @objc func handleTap(_ gesture: UITapGestureRecognizer) {
            let location = gesture.location(in: gesture.view)
            guard let width = gesture.view?.bounds.width else { return }
            if location.x < width / 2 {
                onLeftTap()
            } else {
                onRightTap()
            }
        }
        
        @objc func handleSwipeLeft(_ gesture: UISwipeGestureRecognizer) {
            onRightTap()
        }
        
        @objc func handleSwipeRight(_ gesture: UISwipeGestureRecognizer) {
            onLeftTap()
        }
    }
}
