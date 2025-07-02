import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

//typealias SearchStations = Components.Schemas.SearchResponce

protocol SearchStationsServiceProtocol {
    func searchStations(from: String, to: String) async throws -> [ServiceInformation]
}

actor SearchStationsService: SearchStationsServiceProtocol {
    
    private let client: Client
    private let apikey: String
    
    init() {
        self.client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        self.apikey = APIKeyStore.shared.getAPIKey()
    }
    
    func searchStations(from: String, to: String) async throws -> [ServiceInformation] {
        do {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.string(from: Date())
            
            let response = try await client.searchStations(
                query: .init(
                    apikey: apikey,
                    from: from,
                    to: to,
                    date: date,
                    transfers: true
                )
            )
            
            let searchStationResponse = try response.ok.body.json
            var result: [ServiceInformation] = []
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            let dayMonthFormatter = DateFormatter()
            dayMonthFormatter.dateFormat = "d MMMM"
            dayMonthFormatter.locale = Locale(identifier: "ru_RU")
            let isoFormatter = ISO8601DateFormatter()
            isoFormatter.formatOptions = [.withInternetDateTime]
            guard let serviceInformationArray = searchStationResponse.segments else {
                print("Ошибка получения массива маршрутов из searchStationResponse")
                return result
            }
            
            for segment in serviceInformationArray {
                let newSegment: Components.Schemas.Segment = segment.value2
                
                guard let departureDate = isoFormatter.date(from: newSegment.departure ?? ""),
                      let arrivalDate = isoFormatter.date(from: segment.value1.arrival ?? ""),
                      let carrierCodeDouble = newSegment.thread?.value2.carrier?.value1.code,
                      let isTransfer = newSegment.has_transfers,
                      let journeyTimeSeconds = newSegment.duration,
                      let startDate = dateFormatter.date(from: newSegment.start_date ?? ""),
                      let carrierTitle = newSegment.thread?.value2.carrier?.value1.title
                else {
                    continue
                }
                
                let departureTimeString = timeFormatter.string(from: departureDate)
                let arrivalTimeString = timeFormatter.string(from: arrivalDate)
                let dateString = dayMonthFormatter.string(from: startDate)
                let carrierCode = String(Int(carrierCodeDouble))
                
                let newService: ServiceInformation = ServiceInformation(
                    departureTime: departureTimeString,
                    arrivalTime: arrivalTimeString,
                    carrierCode: carrierCode,
                    imageURL: URL(string: newSegment.thread?.value2.carrier?.value1.logo ?? ""),
                    carrierTitle: carrierTitle,
                    isTransfer: isTransfer,
                    journeyTime: Int(ceil(journeyTimeSeconds / 3600)),
                    date: dateString
                )
                
                result.append(newService)
            }
            
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
}

