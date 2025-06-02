import SwiftUI

class FilterViewModel: ObservableObject {
    @Published var isTransfer = false
    @Published var selectedTime: Set<TimeRange> = []
}
