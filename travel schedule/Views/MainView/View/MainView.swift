import SwiftUI

struct MainView: View {
    // MARK: - UI Constants
    private let externalViewHeight: Double = 128

    // MARK: - State and Bindings
    @Binding var path: NavigationPath
    @StateObject private var filterViewModel = FilterViewModel()
    @State private var from: DeparturePoint = DeparturePoint(city: "", station: "")
    @State private var to: DeparturePoint = DeparturePoint(city: "", station: "")
    @State private var showFindButton: Bool = false
    
    private var isFindButtonEnabled: Bool {
        !from.city.isEmpty && !to.city.isEmpty && !from.station.isEmpty && !to.station.isEmpty
    }
    
    private func change() {
        (from, to) = (to, from)
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.customWhite
                .ignoresSafeArea()
            VStack {
                StoriesPreviewCollection()
                    .padding(.vertical, 24)
                    .padding(.leading, 16)
                
                StationsSelectionSection(from: $from, to: $to, change: change)
                    .frame(maxWidth: .infinity)
                    .frame(height: externalViewHeight)
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                
                if showFindButton {
                    FindButton {
                        path.append(Destination.listOfCarriers)
                    }
                    .transition(.opacity.combined(with: .scale))
                }
                
                Spacer()
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .onChange(of: isFindButtonEnabled, initial: true) { _, enabled in
                withAnimation {
                    showFindButton = enabled
                }
            }
        }
        .navigationDestination(for: Destination.self) { destination in
            NavigationDestinationView(
                destination: destination,
                from: $from,
                to: $to,
                path: $path,
                filterViewModel: filterViewModel
            )
        }
    }
}

#Preview {
    NavigationStack {
        MainView(path: .constant(NavigationPath()))
            .environmentObject(ViewedStoriesStore())
    }
}


