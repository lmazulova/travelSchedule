//
//  MainViewModel.swift
//  travel schedule
//
//  Created by user on 28.06.2025.
//

import SwiftUI

@MainActor
final class MainViewModel: ObservableObject {
    @Published var from: DeparturePoint = DeparturePoint(city: "", station: "") {
        didSet {
            updateFindButtonVisibility()
        }
    }
    
    @Published var to: DeparturePoint = DeparturePoint(city: "", station: "") {
        didSet {
            updateFindButtonVisibility()
        }
    }
    
    @Published var showFindButton: Bool = false
    
    func changeDeparturePoints() {
        (from, to) = (to, from)
    }
    
    var isFindButtonEnabled: Bool {
        !from.city.isEmpty && !to.city.isEmpty &&
        !from.station.isEmpty && !to.station.isEmpty
    }
    
    private func updateFindButtonVisibility() {
        withAnimation {
            showFindButton = isFindButtonEnabled
        }
    }
}
