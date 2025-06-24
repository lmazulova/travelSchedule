import Foundation

struct CarrierInfo {
    let title: String
    let email: String
    let phoneNumber: String
    let imageURL: URL?
    
    init(title: String, email: String, phoneNumber: String, imageURL: URL?) {
        self.title = title
        self.email = email
        self.phoneNumber = phoneNumber
        self.imageURL = imageURL
    }
}

// MARK: - Mock Data for CarrierInfo
extension CarrierInfo {
    static let mock = CarrierInfo(
        title: "Аэрофлот",
        email: "callcenter@aeroflot.ru",
        phoneNumber: "+7 (495) 223-55-55",
        imageURL: URL(string: "https://yastat.net/s3/rasp/media/data/company/logo/aeroflot_logo_ru.gif")
    )
}
