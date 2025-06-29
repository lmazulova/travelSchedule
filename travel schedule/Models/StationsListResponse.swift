import Foundation

struct StationsListResponse: Decodable {
    let settlements: [Settlement]
    
    enum CodingKeys: CodingKey {
        case countries
    }
    
    private struct Countries: Decodable {
        let title: String
        let settlements: [Settlement]
        
        enum CodingKeys: String, CodingKey {
            case regions, title
        }
        
        struct Region: Decodable {
            let settlements: [Settlement]
        }
        
        init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let regions = try container.decode([Countries.Region].self, forKey: .regions)
            
            self.title = try container.decode(String.self, forKey: .title)
            let allSettlements = regions.flatMap{ $0.settlements }
            let filteredSettlements = allSettlements.filter { $0.stations.contains(where: { $0.transportType == "train" }) }
            self.settlements = filteredSettlements
        }
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let countries = try container.decode([Countries].self, forKey: .countries)
        //Оставляем данные по России
        guard let russia = countries.first(where: { $0.title == "Россия" }) else {
            throw DecodingError.dataCorruptedError(forKey: .countries, in: container, debugDescription: "Russia not found in countries")
        }
        //Оставляем только те поселения, в которых есть станции после фильтрации по типу транспорта "поезд"
        let allSettlements = russia.settlements.filter { !$0.stations.isEmpty }
        self.settlements = allSettlements
    }
}

struct Settlement: Decodable {
    let title: String
    let stations: [Station]

    enum CodingKeys: CodingKey {
        case title, stations
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        let allStations = try container.decode([Station].self, forKey: .stations)
        // Оставляем только станции с типом транспорта "поезд"
        self.stations = allStations.filter { $0.transportType == "train" }
    }
}

struct Station: Decodable {
    let title: String
    let code: String
    let transportType: String
    
    enum CodingKeys: String, CodingKey {
        case title, codes, transportType
    }
    
    struct StationCodes: Codable {
        let yandexCode: String
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        let codes = try container.decode(StationCodes.self, forKey: .codes)
        self.code = codes.yandexCode
        self.transportType = try container.decode(String.self, forKey: .transportType)
    }
}
