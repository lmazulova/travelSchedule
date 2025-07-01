//
//  ListOfCarriersViewModel.swift
//  travel schedule
//
//  Created by user on 29.06.2025.
//

import SwiftUI

@MainActor
final class ListOfCarriersViewModel: ObservableObject {
    @ObservedObject var filterViewModel: FilterViewModel
    @Published var allTrainServices: [ServiceInformation] = []
    @Published var filteredTrainServices: [ServiceInformation] = []
    //Selected stations codes
    @Published var from: String = ""
    @Published var to: String = ""
    @Published var isLoading: Bool = false
    
    private let searchStationsService: SearchStationsServiceProtocol
    
    init(
        searchStationsService: SearchStationsServiceProtocol = SearchStationsService(),
        filterViewModel: FilterViewModel = FilterViewModel()
    ) {
        self.searchStationsService = searchStationsService
        self.filterViewModel = filterViewModel
    }
//    init() {
//        self.searchStationsService = SearchStationsService()
//        self._filterViewModel = ObservedObject(wrappedValue: FilterViewModel())
//    }
    
    func fetchAllTrainServices() async throws {
        isLoading = true
        let allStations = try await searchStationsService.searchStations(from: from, to: to)
        self.allTrainServices = allStations
        print(allStations)
        isLoading = false
    }
}
