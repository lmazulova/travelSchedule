import SwiftUI

struct FilterView: View {
    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Время отправления")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.customBlack)
                    .padding(.bottom, 16)
                
                ForEach(TimeRange.allCases, id: \.self) { range in
                    TimeRaw(title: range.rawValue, isSelected: false)
                }
            }
            VStack(alignment: .leading, spacing: 0) {
                Text("Показывать варианты с пересадками")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.customBlack)
                    .padding(.bottom, 16)
                
                ToggleRaw(title: "Да", isSelected: false)
                ToggleRaw(title: "Нет", isSelected: true)
                
            }
            Spacer()
        }
        .padding(16)
    }
}

#Preview {
    FilterView()
}
