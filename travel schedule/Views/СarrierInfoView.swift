import SwiftUI

struct CarrierInfoView: View {
    @Binding var path: NavigationPath
    @StateObject private var viewModel = CarrierInfoViewModel()
    
    let carrierInfo: CarrierInfo
    
    private let stackHeight: Double = 60
    private let logoHeight: Double = 104
    
    init(carrierInfo: CarrierInfo, path: Binding<NavigationPath>) {
        self.carrierInfo = carrierInfo
        self._path = path
    }
    
    var body: some View {
        ZStack {
            backgroundView
            if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(1.5)
            } else if let error = viewModel.errorType {
                ErrorView(errorType: error)
            } else {
                contentView
            }
        }
        .navigationTitle("Информация о перевозчике")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
            }
        }
        .task {
            await viewModel.getCarrierInfo()
        }
    }
    
    //MARK: - UI Elements
    private var contentView: some View {
        VStack(spacing: 16) {
            logoView
            titleView
            contactStack
            Spacer()
        }
        .padding(16)
    }
    
    private var backgroundView: some View {
        Color.customWhite
            .ignoresSafeArea()
    }
    
    private var logoView: some View {
        Group {
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
        }
    }
    
    private var titleView: some View {
        Text(carrierInfo.title)
            .font(.system(size: 24, weight: .bold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.customBlack)
    }
    
    private var contactStack: some View {
        VStack {
            contactItem(title: "E-mail", value: carrierInfo.email)
            contactItem(title: "Телефон", value: carrierInfo.phoneNumber)
        }
    }
    
    private func contactItem(title: String, value: String) -> some View {
        VStack {
            Text(title)
                .font(.system(size: 17, weight: .regular))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.customBlack)
            
            Text(value)
                .font(.system(size: 12, weight: .regular))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.customBlue)
        }
        .frame(height: stackHeight)
    }
    
    private var backButton: some View {
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

#Preview {
    NavigationStack {
        CarrierInfoView(
            carrierInfo: CarrierInfo.mock,
            path: .constant(NavigationPath())
        )
    }
}
