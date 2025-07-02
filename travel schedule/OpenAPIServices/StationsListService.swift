import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

actor StationsListService {
    
    private let client: Client
    private let apikey: String
    
    init() {
        self.client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        self.apikey = APIKeyStore.shared.getAPIKey()
    }
    
    func getSettlementsListForTrain() async throws -> [Settlement] {
        let response = try await fetchStationList()
        let russianSettlements: [Settlement] = response.countries.filter{ $0.title == "Россия" }.flatMap { $0.settlements }
        
        let result = russianSettlements.map { settlement in
            let trainStations = settlement.stations.filter { $0.transportType == "train" }
            return Settlement(
                title: settlement.title,
                stations: trainStations
            )
        }.filter { !$0.stations.isEmpty && !$0.title.isEmpty}
        
        return result
    }
    
    func fetchStationList() async throws -> StationsListResponse {
        do {
            let response = try await client.getStationsList(
                query: .init(
                    apikey: apikey
                )
            )
            let htmlBody = try response.ok.body.html
            let htmlData = try await collectData(from: htmlBody)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode(StationsListResponse.self, from: htmlData)
            return result
        } catch {
            if error is OpenAPIRuntime.ClientError {
                print("Client error: \(error)")
                throw ErrorViewType.networkError
            } else {
                print("Server error: \(error)")
                throw ErrorViewType.serverError
            }
        }
    }
    
    private func collectData(from body: HTTPBody) async throws -> Data {
        var data = Data()
        for try await chunk in body {
            data.append(contentsOf: chunk)
        }
        return data
    }
}


