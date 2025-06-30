import SwiftUI
import Combine

enum SelectionMode {
    case from
    case to
}
@MainActor
final class SelectionViewModel: ObservableObject {
    //Делаем одну VM для выбора и станции отправления, и станции прибытия
    @Published var selectionMode: SelectionMode = .from
    //MARK: - Departure(From) Properties
    @Published var initialSelectedSettlementFrom: Settlement?
    @Published var selectedSettlementFrom: Settlement? {
        didSet {
            allStations = selectedSettlementFrom?.stations ?? []
        }
    }
    @Published var selectedStationFrom: Station? {
        didSet {
            initialSelectedSettlementFrom = selectedSettlementFrom
        }
    }
    //MARK: - Arrival(To) Properties
    @Published var initialSelectedSettlementTo: Settlement?
    @Published var selectedSettlementTo: Settlement? {
        didSet {
            allStations = selectedSettlementTo?.stations ?? []
        }
    }
    @Published var selectedStationTo: Station? {
        didSet {
            initialSelectedSettlementTo = selectedSettlementTo
        }
    }
    
    //MARK: - Loading
    @Published var isLoading: Bool = false
    
    //MARK: - Stations/Settlements
    @Published var allStations: [Station]
    @Published var allSettlements: [Settlement]
    
    //MARK: - Filtration Properties
    @Published var searchSettlementText = ""
    @Published var searchStationText = ""
    @Published var filteredSettlements: [Settlement] = []
    @Published var filteredStations: [Station] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - Init
    init() {
        self.allSettlements = []
        self.allStations = []
        Publishers.CombineLatest($searchSettlementText, $allSettlements)
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] (debouncedText, allSettlements) in
                guard let self else { return }
                self.filteredSettlements = debouncedText.isEmpty
                ? allSettlements
                : allSettlements.filter { $0.title.lowercased().contains(debouncedText.lowercased()) }
            }
            .store(in: &cancellables)
        
        Publishers.CombineLatest($searchStationText, $allStations)
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] (debouncedText, allStations) in
                guard let self else { return }
                self.filteredStations = debouncedText.isEmpty
                ? allStations
                : allStations.filter { $0.title.lowercased().contains(debouncedText.lowercased()) }
            }
            .store(in: &cancellables)
    }
    
    func changeDeparturePoints() {
        let tempInitialFrom = initialSelectedSettlementFrom
        let tempFrom = selectedSettlementFrom
        let tempStationFrom = selectedStationFrom
        
        initialSelectedSettlementFrom = initialSelectedSettlementTo
        selectedSettlementFrom = selectedSettlementTo
        selectedStationFrom = selectedStationTo
        
        initialSelectedSettlementTo = tempInitialFrom
        selectedSettlementTo = tempFrom
        selectedStationTo = tempStationFrom
    }
    
    func selectStation(_ station: Station) {
        switch selectionMode {
        case .from:
            selectedStationFrom = station
        case .to:
            selectedStationTo = station
        }
    }
    
    func selectSettlement(_ settlement: Settlement) {
        switch selectionMode {
        case .from:
            selectedSettlementFrom = settlement
        case .to:
            selectedSettlementTo = settlement
        }
    }
}
