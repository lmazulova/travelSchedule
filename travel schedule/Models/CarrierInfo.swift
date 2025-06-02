import Foundation

struct CarrierInfoModel {
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
