import SwiftUI

final class SelectionDataViewModelMock: ObservableObject {
    @Published var searchText = ""
    
    @Published var foundRoutes: [ServiceInformation] = [
        ServiceInformation(
            departureTime: "22:30",
            arrivalTime: "8:15",
            carrier: "РЖД",
            imageURL: URL(string: "https://yastat.net/s3/rasp/media/data/company/logo/logo.gif")!,
            isTransfer: false,
            journeyTime: 20,
            date: "14 января"
        ),
        ServiceInformation(
            departureTime: "22:30",
            arrivalTime: "8:15",
            carrier: "РЖД",
            imageURL: URL(string: "https://yastat.net/s3/rasp/media/data/company/logo/logo.gif")!,
            isTransfer: true,
            journeyTime: 20,
            date: "14 января"
        ),
        ServiceInformation(
            departureTime: "22:30",
            arrivalTime: "2:15",
            carrier: "Аэрофлот",
            imageURL: URL(string: "https://yastat.net/s3/rasp/media/data/company/logo/aeroflot_logo_ru.gif")!,
            isTransfer: false,
            journeyTime: 4,
            date: "14 января"
        ),
        ServiceInformation(
            departureTime: "22:30",
            arrivalTime: "8:15",
            carrier: "РЖД",
            imageURL: URL(string: "https://yastat.net/s3/rasp/media/data/company/logo/logo.gif")!,
            isTransfer: false,
            journeyTime: 20,
            date: "14 января"
        )
    ]
    var filteredCities: [String] {
        searchText.isEmpty ? cities : cities.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }
    private let cities: [String] = ["Москва", "Санкт-Петербург", "Сочи", "Горный воздух", "Краснодар", "Казань", "Омск"]
    
    private let railwayStations: [String] = ["Киевский вокзал", "Курский вокзал", "Ярославский вокзал", "Белорусский вокзал", "Савеловский вокзал", "Ленинградский вокзал"]
    
    var filteredRailwayStations: [String] {
        searchText.isEmpty ? railwayStations : railwayStations.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }
}
