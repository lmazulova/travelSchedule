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
    @Published var selectionViewModel: SelectionViewModel
    
    private let stationListService: StationsListServiceProtocol
    
    init(stationListService: StationsListServiceProtocol = StationsListService()) {
        self.stationListService = stationListService
        self.selectionViewModel = SelectionViewModel(allSettlements: [])
        Task {
            await loadSettlements()
        }
    }
    
    var isFindButtonEnabled: Bool {
        !from.city.isEmpty && !to.city.isEmpty &&
        !from.station.isEmpty && !to.station.isEmpty
    }
    
    func changeDeparturePoints() {
        (from, to) = (to, from)
    }
    
    private func updateFindButtonVisibility() {
        withAnimation {
            showFindButton = isFindButtonEnabled
        }
    }
    
    private func loadSettlements() async {
        do {
            let response = try await stationListService.getStationsList()
            let allSettlements = response.settlements
            selectionViewModel.allSettlements = allSettlements
        } catch {
            print("Ошибка загрузки settlements: \(error)")
            selectionViewModel.allSettlements = []
        }
    }
}
