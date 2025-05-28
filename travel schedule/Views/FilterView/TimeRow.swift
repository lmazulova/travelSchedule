import SwiftUI

struct TimeRaw: View {
    let title: String
    private var rowHeight: Double = 60
    private let iconSize: Double = 24
    @State var isSelected: Bool
    
    init(title: String, isSelected: Bool) {
        self.title = title
        self.isSelected = isSelected
    }
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 17, weight: .regular))
            
            Spacer()
            
            Toggle(isOn: $isSelected) {
                Image(isSelected ? "checkmark_square_fill" : "checkmark_square")
                    .frame(width: iconSize, height: iconSize)
                    .foregroundStyle(Color.customBlack)
            }
            .toggleStyle(.button)
            .buttonStyle(PlainButtonStyle())
        }
        .frame(height: rowHeight)
    }
}

#Preview {
    TimeRaw(title: "Утро 06:00 - 12:00", isSelected: false)
}
