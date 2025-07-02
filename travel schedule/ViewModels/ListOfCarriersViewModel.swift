//
//  ListOfCarriersViewModel.swift
//  travel schedule
//
//  Created by user on 29.06.2025.
//

import SwiftUI
import Combine

@MainActor
final class ListOfCarriersViewModel: ObservableObject {
    @Published private(set) var filterViewModel: FilterViewModel = FilterViewModel()
    @Published private(set) var carrierInfoViewModel: CarrierInfoViewModel = CarrierInfoViewModel()
    @Published private(set) var allTrainServices: [ServiceInformation] = []
    @Published private(set) var filteredTrainServices: [ServiceInformation] = []
    //Selected stations codes
    @Published var from: String = ""
    @Published var to: String = ""
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    private let searchStationsService: SearchStationsServiceProtocol
    
    init(searchStationsService: SearchStationsServiceProtocol = SearchStationsService()) {
        self.searchStationsService = searchStationsService
        setupBindings()
    }
    
    func fetchAllTrainServices() async throws {
        isLoading = true
        let allStations = try await searchStationsService.searchStations(from: from, to: to)
        self.allTrainServices = allStations
        self.applyFilters()
        isLoading = false
    }
    
    func selectCarrier(with code: String) {
        carrierInfoViewModel.setCarrierCode(code)
    }
    
    func setupBindings() {
        //Объединяем всех издателей, т.к. нам нужно одинаковое поведение
        let publishers: [AnyPublisher<Void, Never>] = [
            filterViewModel.$isTransfer.map { _ in }.eraseToAnyPublisher(),
            filterViewModel.$selectedTime.map { _ in }.eraseToAnyPublisher()
        ]
        
        Publishers.MergeMany(publishers)
            .sink { [weak self] in
                self?.applyFilters()
            }
            .store(in: &cancellables)
    }
    
    private func applyFilters() {
        filteredTrainServices = allTrainServices.filter { service in
            // фильтрация по времени и пересадкам
            let matchesTime = filterViewModel.selectedTime.isEmpty
            ? true
            : filterViewModel.selectedTime.contains { range in
                isTime(service.departureTime, in: range)
            }
            let matchesTransfer = filterViewModel.isTransfer ? true : service.isTransfer == false
            return matchesTime && matchesTransfer
        }
    }
    
    private func isTime(_ timeString: String, in range: TimeRange) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        guard let date = formatter.date(from: timeString) else { return false }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date)
        guard let hour = components.hour, let minute = components.minute else { return false }
        let totalMinutes = hour * 60 + minute

        switch range {
        case .morning:   // 06:00 - 12:00
            return totalMinutes >= 6 * 60 && totalMinutes < 12 * 60
        case .afternoon: // 12:00 - 18:00
            return totalMinutes >= 12 * 60 && totalMinutes < 18 * 60
        case .evening:   // 18:00 - 00:00
            return totalMinutes >= 18 * 60 && totalMinutes < 24 * 60
        case .night:     // 00:00 - 06:00
            return totalMinutes >= 0 && totalMinutes < 6 * 60
        }
    }
}
