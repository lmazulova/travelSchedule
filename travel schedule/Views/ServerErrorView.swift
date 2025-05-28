import SwiftUI

struct ErrorView: View {
    let text: String
    let image: Image
    init(text: String, image: Image) {
        self.text = text
        self.image = image
    }
    private let imageSize: Double = 223
    
    var body: some View {
        VStack(spacing: 16) {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: imageSize, height: imageSize)
                .clipShape(RoundedRectangle(cornerRadius: 70))
            Text(text)
                .font(.system(size: 24, weight: .bold))
        }
        .padding()
    }
}

#Preview {
    ErrorView(text: "Ошибка сервера", image: Image("serverError"))
}
