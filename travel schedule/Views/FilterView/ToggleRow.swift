import SwiftUI

struct ToggleRowView: View {
    private let title: String
    private var rowHeight: Double = 60
    private let iconSize: Double = 24
    @Binding var isSelected: Bool
    
    init(title: String, isSelected: Binding<Bool>) {
        self.title = title
        self._isSelected = isSelected
    }
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 17, weight: .regular))
            
            Spacer()
            
            Toggle(isOn: $isSelected) {
                Image(isSelected ? "checkmark_circle_fill" : "checkmark_circle")
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
    struct ToggleRowViewPreviews: View {
        @State private var isSelected = false
        var body: some View {
            ToggleRowView(title: "Да", isSelected: $isSelected)
        }
    }
    return ToggleRowViewPreviews()
}
