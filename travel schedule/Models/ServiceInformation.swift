import Foundation

struct ServiceInformation: Identifiable {
    let id = UUID()
    let departureTime: String
    let arrivalTime: String
    let carrier: String
    let imageURL: URL
    let isTransfer: Bool
    let journeyTime: Int
    let date: String
}
