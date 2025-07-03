import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

actor CarrierInfoService {
    
    private let client: Client
    private let apikey: String
    
    init() {
        self.client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        self.apikey = APIKeyStore.shared.getAPIKey()
    }
    
    func getCarrierInfo(code: String) async throws -> CarrierInfo {
        do {
            let response = try await client.getCarrier(
                query: .init(
                    apikey: apikey,
                    code: code
                )
            )
            let carrierResponse = try response.ok.body.json
            
            var imageURL: URL? = nil
            if let logoString = carrierResponse.carrier?.logo, !logoString.isEmpty {
                imageURL = URL(string: logoString)
            }
            
            let carrierInfo: CarrierInfo = CarrierInfo(
                title: carrierResponse.carrier?.title ?? "",
                email: carrierResponse.carrier?.email ?? "",
                phoneNumber: carrierResponse.carrier?.phone ?? "",
                imageURL: imageURL
            )
            
            return carrierInfo
        }
        catch {
            if error is OpenAPIRuntime.ClientError {
                print("Client error: \(error)")
                throw ErrorViewType.networkError
            } else {
                print("Server error: \(error)")
                throw ErrorViewType.serverError
            }
        }
    }
}
