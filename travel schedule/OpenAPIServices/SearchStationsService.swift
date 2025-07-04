import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

actor SearchStationsService {
    
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
                    transport_types: "train",
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
                let newSegment: Components.Schemas.Segment = segment.value1
                
                if newSegment.has_transfers {
                    guard let departureDate = isoFormatter.date(from: newSegment.departure),
                          let arrivalDate = isoFormatter.date(from: newSegment.arrival),
                          let details = newSegment.details,
                          let transfers = newSegment.transfers,
                          let carrierTitle = newSegment.details?.first?.thread?.carrier.title
                    else {
                        continue
                    }
                    var carrierCode = ""
                    var journeyTime: Double = 0
                    let transferStation = transfers.first?.short_title ?? ""
                    
                    for detail in details {
                        if carrierCode.isEmpty {
                            if let code = detail.thread?.carrier.code {
                                carrierCode = String(Int(code))
                            }
                        }
                        journeyTime += detail.duration ?? 0
                    }
                    let departureTimeString = timeFormatter.string(from: departureDate)
                    let arrivalTimeString = timeFormatter.string(from: arrivalDate)
                    
                    let newService: ServiceInformation = ServiceInformation(
                        departureTime: departureTimeString,
                        arrivalTime: arrivalTimeString,
                        carrierCode: carrierCode,
                        imageURL: nil,
                        carrierTitle: carrierTitle,
                        isTransfer: newSegment.has_transfers,
                        transferStation: transferStation,
                        journeyTime: Int(ceil(journeyTime / 3600)),
                        date: dayMonthFormatter.string(from: departureDate)
                    )
                    
                    result.append(newService)
                } else {
                    guard let departureDate = isoFormatter.date(from: newSegment.departure),
                          let arrivalDate = isoFormatter.date(from: newSegment.arrival),
                          let carrierCodeDouble = newSegment.thread?.value1.carrier?.value1.code,
                          let journeyTimeSeconds = newSegment.duration,
                          let startDate = dateFormatter.date(from: newSegment.start_date ?? ""),
                          let carrierTitle = newSegment.thread?.value1.carrier?.value1.title
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
                        imageURL: URL(string: newSegment.thread?.value1.carrier?.value1.logo ?? ""),
                        carrierTitle: carrierTitle,
                        isTransfer: newSegment.has_transfers,
                        transferStation: nil,
                        journeyTime: Int(ceil(journeyTimeSeconds / 3600)),
                        date: dateString
                    )
                    
                    result.append(newService)
                }
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

