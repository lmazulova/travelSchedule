import SwiftUI

struct CarrierInfoView: View {
    @Binding var path: NavigationPath
    let carrierInfo: CarrierInfoModel
    
    private let stackHeight: Double = 60
    private let logoHeight: Double = 104
    
    init(carrierInfo: CarrierInfoModel, path: Binding<NavigationPath>) {
        self.carrierInfo = carrierInfo
        self._path = path
    }
    
    var body: some View {
        ZStack {
            Color.customWhite
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                if let imageURL = carrierInfo.imageURL {
                    AsyncImage(url: imageURL) { content in
                        content.image?
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: logoHeight)
                            .padding([.leading, .trailing], 16)
                    }
                    .background(Color.white)
                    .clipShape(.rect(cornerRadius: 24))
                }
                
                Text(carrierInfo.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.customBlack)
                
                VStack {
                    VStack {
                        Text("E-mail")
                            .font(.system(size: 17, weight: .regular))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.customBlack)
                        
                        Text(carrierInfo.email)
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
                        
                        Text(carrierInfo.phoneNumber)
                            .font(.system(size: 12, weight: .regular))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.customBlue)
                    }
                    .frame(height: stackHeight)
                }
                
                Spacer()
            }
            .padding(16)
            .navigationTitle("Информация о перевозчике")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        path.removeLast()
                    } label: {
                        Image("backArrow")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 17, height: 22)
                    }
                }
            }
        }
    }
}

#Preview {
//    CarrierInfoView(
//        carrierInfo: CarrierInfoModel(
//            title: "Аэрофлот",
//            email: "callcenter@aeroflot.ru",
//            phoneNumber: "+7 (495) 223-55-55",
//            imageURL: URL(string: "https://yastat.net/s3/rasp/media/data/company/logo/aeroflot_logo_ru.gif")
//        )
//    )
}
