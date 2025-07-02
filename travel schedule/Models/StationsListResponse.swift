import Foundation

struct StationsListResponse: Decodable, Sendable {
    let countries: [Country]
}

struct Country: Decodable {
    let settlements: [Settlement]
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case regions, title
    }
    
    struct Region: Decodable {
        let settlements: [Settlement]
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let regions = try container.decode([Region].self, forKey: .regions)
        self.title = try container.decode(String.self, forKey: .title)
        self.settlements = regions.flatMap{ $0.settlements }
    }
}

struct Settlement: Decodable, Hashable, Sendable {
    
    let title: String
    let stations: [Station]
    
    enum CodingKeys: String, CodingKey {
        case title, codes, stations
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.stations = try container.decode([Station].self, forKey: .stations)
    }
    
    init(title: String, stations: [Station]) {
        self.title = title
        self.stations = stations
    }
}

struct Station: Decodable, Hashable, Sendable {
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
