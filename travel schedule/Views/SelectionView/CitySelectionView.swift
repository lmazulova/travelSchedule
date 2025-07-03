import SwiftUI

struct CitySelectionView: View {
    private let iconSize: Double = 24
    private let rowHeight: Double = 60
    @Binding var path: NavigationPath
    var destination: Destination
    @StateObject private var viewModel: SelectionViewModel
    
    init(path: Binding<NavigationPath>, destination: Destination, viewModel: SelectionViewModel) {
        self.destination = destination
        self._path = path
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color.customWhite
                .ignoresSafeArea()
                .contentShape(Rectangle())
                .onTapGesture {
                    UIApplication.shared.hideKeyboard()
                }
            
            VStack {
                CustomSearchBar(searchText: $viewModel.searchSettlementText)
                
                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                        .scaleEffect(1.5)
                    Spacer()
                } else if let error = viewModel.errorType {
                    ErrorView(errorType: error)
                } else if !viewModel.filteredSettlements.isEmpty {
                    List(viewModel.filteredSettlements, id: \.self) { settlement in
                        HStack {
                            Text(settlement.title)
                                .font(.system(size: 17, weight: .regular))
                                .foregroundStyle(Color.customBlack)
                            
                            Spacer()
                            
                            Image("arrow")
                                .frame(width: iconSize, height: iconSize)
                        }
                        .listRowBackground(Color.customWhite)
                        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                        .frame(height: rowHeight)
                        .listRowSeparator(.hidden)
                        .background(Color.customWhite)
                        .onTapGesture {
                            viewModel.selectSettlement(settlement)
                            path.append(destination)
                        }
                    }
                    .listStyle(.plain)
                    .padding(.bottom, 15)
                } else {
                    Spacer()
                    Text("Город не найден")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(Color.customBlack)
                    Spacer()
                }
            }
            .navigationTitle("Выбор города")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
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
        .toolbar(.hidden, for: .tabBar)
    }
}

//#Preview {
//    CitySelectionView()
//}
