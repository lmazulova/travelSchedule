//
//  SelectionViewModel.swift
//  travel schedule
//
//  Created by user on 28.06.2025.
//

import SwiftUI

@MainActor
final class SelectionViewModel: ObservableObject {
    @Published var initialSelectedCity: String = ""
    @Published var selectedCitys: String = ""
    @Published var selectedStation: String = ""
    @Published var initialSelectedStation: String = ""
    var allSettlements: [Settlement]
    
    init(allSettlements: [Settlement]) {
        self.allSettlements = allSettlements
    }
}
