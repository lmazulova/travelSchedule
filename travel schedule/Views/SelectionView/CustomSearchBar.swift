import SwiftUI

struct CustomSearchBar: View {
    private var iconTitle: String { searchText.isEmpty ? "magnifyingGlass" : "magnifyingGlassFill" }
    private let viewHeight: Double = 36
    private let glassIconHeight: Double = 22
    private let glassIconWidth: Double = 25
    private let clearIconHeight: Double = 22
    private let clearIconWidth: Double = 20
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(iconTitle)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: glassIconWidth, height: glassIconHeight)
                .padding(.leading, 8)
            TextField(
                "",
                text: $searchText,
                prompt: Text("Введите запрос")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(Color.customGray)
            )
                .autocorrectionDisabled()
                .font(.system(size: 17, weight: .regular))
                .foregroundStyle(Color.customBlack)
            if !searchText.isEmpty {
                Button(action: {searchText = "" }) {
                    Image("clear")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: clearIconWidth, height: clearIconHeight)
                        .padding(.trailing, 6)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: viewHeight)
        .background(Color.customLightGrayDayAndNight)
        .clipShape(.rect(cornerRadius: 10))
        .padding(16)
    }
}

#Preview {
//    CustomSearchBar()
}
