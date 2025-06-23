import OpenAPIRuntime
import OpenAPIURLSession

typealias CarrierInfoResponse = Components.Schemas.CarrierResponce

protocol CarrierInfoServiceProtocol {
    func getCarrierInfo(code: String) async throws -> CarrierInfoResponse
}

final class CarrierInfoService: CarrierInfoServiceProtocol {
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getCarrierInfo(code: String) async throws -> CarrierInfoResponse {
        let response = try await client.getCarrier(
            query: .init(
                apikey: apikey,
                code: code
            )
        )
        return try response.ok.body.json
    }
}






