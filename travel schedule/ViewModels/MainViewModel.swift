import SwiftUI
import Combine

@MainActor
final class MainViewModel: ObservableObject {
    @Published var from: String = ""
    @Published var to: String = ""
    @Published var showFindButton: Bool = false
    
    private(set) var selectionViewModel: SelectionViewModel = SelectionViewModel()
    //Здесь просто создаем viewModel, а коды выбранных станций пробрасываются в методе setupBindings
    private(set) var listOfCarriersViewModel: ListOfCarriersViewModel = ListOfCarriersViewModel()
    
    private var cancellables = Set<AnyCancellable>()
    private let stationListService: StationsListServiceProtocol
    
    init(stationListService: StationsListServiceProtocol = StationsListService()) {
        self.stationListService = stationListService
        setupBindings()
        Task {
            await loadSettlements()
        }
    }
    
    func changeDeparturePoints() {
        selectionViewModel.changeDeparturePoints()
    }

    private func loadSettlements() async {
        selectionViewModel.isLoading = true
        defer {
            selectionViewModel.isLoading = false
        }
        
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
//        selectionViewModel.$initialSelectedSettlementFrom
//            .sink { [weak self] settlement in
//                guard let self = self,
//                      let  settlement = settlement else { return }
//                self.from.city = settlement.title
//            }
//            .store(in: &cancellables)
        
        selectionViewModel.$selectedStationFrom
            .sink { [weak self] station in
                guard let self = self,
                      let  station = station else { return }
                self.from = station.title
                self.listOfCarriersViewModel.from = station.code
            }
            .store(in: &cancellables)
        
//        selectionViewModel.$initialSelectedSettlementTo
//            .sink { [weak self] settlement in
//                guard let self = self,
//                      let  settlement = settlement else { return }
//                self.to.city = settlement.title
//            }
//            .store(in: &cancellables)
        
        selectionViewModel.$selectedStationTo
            .sink { [weak self] station in
                guard let self = self,
                      let  station = station else { return }
                self.to = station.title
                self.listOfCarriersViewModel.to = station.code
            }
            .store(in: &cancellables)
        
        //Проверяем можно ли показать кнопку "найти"
        Publishers.CombineLatest($from, $to)
            .map { from, to in
                !from.isEmpty && !to.isEmpty
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
