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
    
    init(departureTime: String, arrivalTime: String, carrier: String, imageURL: URL, isTransfer: Bool, journeyTime: Int, date: String) {
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
        self.carrier = carrier
        self.imageURL = imageURL
        self.isTransfer = isTransfer
        self.journeyTime = journeyTime
        self.date = date
    }
}
