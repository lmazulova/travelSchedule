import SwiftUI

struct CargoInfoView: View {
    let title: String
    let email: String
    let phoneNumber: String
    let imageURL: URL
    private let stackHeight: Double = 60
    private let logoHeight: Double = 104
    
    init(title: String, email: String, phoneNumber: String, imageURL: URL) {
        self.title = title
        self.email = email
        self.phoneNumber = phoneNumber
        self.imageURL = imageURL
    }
    
    var body: some View {
        VStack(spacing: 16) {
            AsyncImage(url: imageURL) { content in
                content.image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: logoHeight)
                    .padding([.leading, .trailing], 16)
            }
            .background(Color.white)
            .clipShape(.rect(cornerRadius: 24))
            
            Text(title)
                .font(.system(size: 24, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.customBlack)
            
            VStack {
                VStack {
                    Text("E-mail")
                        .font(.system(size: 17, weight: .regular))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.customBlack)
                    
                    Text(email)
                        .font(.system(size: 12, weight: .regular))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.customBlue)
                }
                .frame(height: stackHeight)
                
                VStack {
                    Text("Телефон")
                        .font(.system(size: 17, weight: .regular))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.customBlack)
                    
                    Text(phoneNumber)
                        .font(.system(size: 12, weight: .regular))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.customBlue)
                }
                .frame(height: stackHeight)
            }
            
            Spacer()
        }
        .padding(16)
    }
}

#Preview {
    CargoInfoView(title: "Аэрофлот", email: "callcenter@aeroflot.ru", phoneNumber: "+7 (495) 223-55-55", imageURL: URL(string: "https://yastat.net/s3/rasp/media/data/company/logo/aeroflot_logo_ru.gif")!)
}
