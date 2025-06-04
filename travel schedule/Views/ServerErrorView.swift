import SwiftUI

enum ErrorViewType: String {
    case serverError
    case networkError
}

struct ErrorView: View {
    let errorType: ErrorViewType
    let image: Image
    let text: String
    
    init(errorType: ErrorViewType) {
        self.errorType = errorType
        self.image = Image(errorType.rawValue)
        self.text = errorType == .networkError ? "Нет интернета" : "Ошибка сервера"
    }
    
    private let imageSize: Double = 223
    
    var body: some View {
        ZStack {
            Color.customWhite
                .ignoresSafeArea()
            VStack(spacing: 16) {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageSize, height: imageSize)
                    .clipShape(RoundedRectangle(cornerRadius: 70))
                Text(text)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color.customBlack)
            }
            .padding()
        }
    }
}

#Preview {
    ErrorView(errorType: .serverError)
}
