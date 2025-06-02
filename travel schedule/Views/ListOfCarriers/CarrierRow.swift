import SwiftUI

struct CarrierRow: View {
    let serviceInfo: ServiceInformation
    private let stackHeight: Double = 104
    private let logoSize: Double = 38
    
    init(serviceInfo: ServiceInformation) {
        self.serviceInfo = serviceInfo
    }
    var body: some View {
        VStack(spacing: 4) {
            HStack {
                AsyncImage(url: serviceInfo.imageURL) { content in
                    content.image?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: logoSize, height: logoSize)
                        .background(Color.white)
                        .clipShape(.rect(cornerRadius: 12))
                }
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        
                        Text(serviceInfo.carrier)
                            .font(.system(size: 17, weight: .regular))
                            .foregroundStyle(Color.black)
                        
                        if serviceInfo.isTransfer {
                            Text("С пересадкой в Костроме")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundStyle(Color.customRed)
                        }
                    }
                    
                    Spacer()
                    
                    Text(serviceInfo.date)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(Color.black)
                }
            }
            HStack {
                Text(serviceInfo.departureTime)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(Color.black)
                
                Rectangle()
                    .fill(Color.customGray)
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                
                Text("\(serviceInfo.journeyTime) часов")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(Color.black)
                
                Rectangle()
                    .fill(Color.customGray)
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                
                Text(serviceInfo.arrivalTime)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(Color.black)
            }
        }
        .padding(14)
        .frame(maxWidth: .infinity)
        .frame(height: stackHeight)
        .background(Color.customLightGray)
        .clipShape(.rect(cornerRadius: 24))
        .listRowBackground(Color.customWhite)
    }
}

#Preview {
    CarrierRow(serviceInfo: ServiceInformation(
        departureTime: "22:30",
        arrivalTime: "8:15",
        carrier: "РЖД",
        imageURL: URL(string: "https://yastat.net/s3/rasp/media/data/company/logo/logo.gif")!,
        isTransfer: false,
        journeyTime: 20,
        date: "14 января")
        )
}
