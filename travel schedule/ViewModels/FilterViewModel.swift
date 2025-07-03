import SwiftUI

@MainActor
///ViewModel for managing filter state from FilterView
final class FilterViewModel: ObservableObject {
    @Published var isTransfer = true
    @Published var selectedTime: Set<TimeRange> = []
}
