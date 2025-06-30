import SwiftUI
import Combine

@MainActor
final class MainViewModel: ObservableObject {
    @Published var from: DeparturePoint = DeparturePoint(city: "", station: "")
    @Published var to: DeparturePoint = DeparturePoint(city: "", station: "")
    @Published var showFindButton: Bool = false
    
    var selectionViewModel: SelectionViewModel = SelectionViewModel()
    
    private var cancellables = Set<AnyCancellable>()
    private let stationListService: StationsListServiceProtocol
    
    init(stationListService: StationsListServiceProtocol = StationsListService()) {
        self.stationListService = stationListService
        setupBindings()
        Task {
            selectionViewModel.isLoading = true
            await loadSettlements()
            selectionViewModel.isLoading = false
        }
    }
    
    var isFindButtonEnabled: Bool {
        !from.city.isEmpty && !to.city.isEmpty &&
        !from.station.isEmpty && !to.station.isEmpty
    }
    
    func changeDeparturePoints() {
        selectionViewModel.changeDeparturePoints()
    }

    private func loadSettlements() async {
        do {
            let response = try await stationListService.getSettlementsListForTrain()
            selectionViewModel.allSettlements = response
        } catch {
            print("Ошибка загрузки settlements: \(error)")
            selectionViewModel.allSettlements = []
        }
    }
    
    private func setupBindings() {
        //Обновляем поля с выбранными станциями, для отображения в MainView
        selectionViewModel.$initialSelectedSettlementFrom
            .sink { [weak self] settlement in
                guard let self = self,
                      let  settlement = settlement else { return }
                self.from.city = settlement.title
            }
            .store(in: &cancellables)
        
        selectionViewModel.$selectedStationFrom
            .sink { [weak self] station in
                guard let self = self,
                      let  station = station else { return }
                self.from.station = station.title
            }
            .store(in: &cancellables)
        
        selectionViewModel.$initialSelectedSettlementTo
            .sink { [weak self] settlement in
                guard let self = self,
                      let  settlement = settlement else { return }
                self.to.city = settlement.title
            }
            .store(in: &cancellables)
        
        selectionViewModel.$selectedStationTo
            .sink { [weak self] station in
                guard let self = self,
                      let  station = station else { return }
                self.to.station = station.title
            }
            .store(in: &cancellables)
        
        //Проверяем можно ли показать кнопку "найти"
        Publishers.CombineLatest($from, $to)
            .map { from, to in
                !from.city.isEmpty && !from.station.isEmpty && !to.city.isEmpty && !to.station.isEmpty
            }
            .removeDuplicates()
            .sink { [weak self] enabled in
                withAnimation {
                    self?.showFindButton = enabled
                }
            }
            .store(in: &cancellables)
    }
    
    func setupSelectionMode(_ mode: SelectionMode) {
        selectionViewModel.selectionMode = mode
    }
}
