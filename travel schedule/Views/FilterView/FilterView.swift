import SwiftUI

struct FilterView: View {
    @ObservedObject var filterViewModel: FilterViewModel
    @Binding var path: NavigationPath
    @State private var initialIsTransfer: Bool
    @State private var initialSelectedTime: Set<TimeRange>
    
    init(path: Binding<NavigationPath>, filterViewModel: FilterViewModel) {
        self._path = path
        self._filterViewModel = ObservedObject(wrappedValue: filterViewModel)
        self._initialIsTransfer = State(initialValue: filterViewModel.isTransfer)
        self._initialSelectedTime = State(initialValue: filterViewModel.selectedTime)
    }
    
    var body: some View {
        ZStack {
            Color.customWhite
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Время отправления")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.customBlack)
                        .padding(.bottom, 16)
                    
                    ForEach(TimeRange.allCases, id: \.self) { range in
                        TimeRowView(time: range, selectedTime: $filterViewModel.selectedTime)
                    }
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("Показывать варианты с пересадками")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.customBlack)
                        .padding(.bottom, 16)
                    
                    ToggleRowView(title: "Да", isSelected: $filterViewModel.isTransfer)
                    ToggleRowView(
                        title: "Нет",
                        isSelected: Binding(
                            get: { !filterViewModel.isTransfer },
                            set: { _ in filterViewModel.isTransfer.toggle() }
                        )
                    )
                    
                }
                
                Spacer()
                if filterViewModel.isTransfer != initialIsTransfer || filterViewModel.selectedTime != initialSelectedTime {
                    Button(action: {
                        path.removeLast()
                    }) {
                        HStack(spacing: 4) {
                            Text("Применить")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.customBlue)
                        .clipShape(.rect(cornerRadius: 16))
                        
                    }
                    .frame(height: 60)
                    .padding(.bottom, 24)
                }
            }
            .padding([.top, .horizontal], 16)
            .padding(.bottom, 0)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        filterViewModel.isTransfer = initialIsTransfer
                        filterViewModel.selectedTime = initialSelectedTime
                        path.removeLast()
                    } label: {
                        Image("backArrow")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 17, height: 22)
                    }
                }
            }
        }
    }
}

#Preview {
    struct FilterViewPreview: View {
        @State private var path = NavigationPath()
        @StateObject private var filterViewModel = FilterViewModel()
        var body: some View {
            FilterView(path: $path, filterViewModel: filterViewModel)
            
        }
    }
    return FilterViewPreview()
}
