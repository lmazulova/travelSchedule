import OpenAPIRuntime
import OpenAPIURLSession

typealias SearchStations = Components.Schemas.SearchResponce

protocol SearchStationsServiceProtocol {
    func searchStations(from: String, to: String) async throws -> SearchStations
}

final class SearchStationsService: SearchStationsServiceProtocol {
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func searchStations(from: String, to: String) async throws -> SearchStations {
        let response = try await client.searchStations(
            query: .init(
                apikey: apikey,
                from: from,
                to: to
            )
        )
        return try response.ok.body.json
    }
}

