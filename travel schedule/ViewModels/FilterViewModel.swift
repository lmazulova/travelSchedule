import SwiftUI

///ViewModel for managing filter state from FilterView
final class FilterViewModel: ObservableObject {
    @Published var isTransfer = false
    @Published var selectedTime: Set<TimeRange> = []
}
