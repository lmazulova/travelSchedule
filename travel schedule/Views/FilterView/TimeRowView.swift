import SwiftUI

struct TimeRowView: View {
    let time: TimeRange
    private var rowHeight: Double = 60
    private let iconSize: Double = 24
    @Binding var selectedTime: Set<TimeRange>
    
    init(time: TimeRange, selectedTime: Binding<Set<TimeRange>>) {
        self.time = time
        self._selectedTime = selectedTime
    }
    
    var body: some View {
        HStack {
            Text(time.rawValue)
                .font(.system(size: 17, weight: .regular))
            
            Spacer()
            
            Button(action: addFilter){
                Image(selectedTime.contains(time) ? "checkmark_square_fill" : "checkmark_square")
                    .frame(width: iconSize, height: iconSize)
                    .foregroundStyle(Color.customBlack)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .frame(height: rowHeight)
    }
    func addFilter() {
        if selectedTime.contains(time) {
            selectedTime.remove(time)
        } else {
            selectedTime.insert(time)
        }
    }
}

#Preview {
    struct TimeRowViewPreviews: View {
        @State private var selectedTime: Set<TimeRange> = []
        var body: some View {
            TimeRowView(time: .morning, selectedTime: $selectedTime)
        }
    }
    
    return TimeRowViewPreviews()
}
