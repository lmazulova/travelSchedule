import SwiftUI

struct MainView: View {
    // MARK: - UI Constants
    private let externalViewHeight: Double = 128
    
    // MARK: - State and Bindings
    @Binding var path: NavigationPath
    @StateObject private var filterViewModel = FilterViewModel()
    @StateObject private var viewModel: MainViewModel
    
    init(path: Binding<NavigationPath>) {
        self._path = path
        self._viewModel = StateObject(wrappedValue: MainViewModel())
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
                
                StationsSelectionSection(
                    from: $viewModel.from,
                    to: $viewModel.to,
                    change: viewModel.changeDeparturePoints,
                    onToTap: { viewModel.setupSelectionMode(.to) },
                    onFromTap: { viewModel.setupSelectionMode(.from) }
                )
                    .frame(maxWidth: .infinity)
                    .frame(height: externalViewHeight)
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                
                if viewModel.showFindButton {
                    FindButton {
                        path.append(Destination.listOfCarriers)
                    }
                    .transition(.opacity.combined(with: .scale))
                }
                
                Spacer()
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .navigationDestination(for: Destination.self) { destination in
            NavigationDestinationView(
                destination: destination,
                from: $viewModel.from,
                to: $viewModel.to,
                path: $path,
                mainViewModel: viewModel
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


