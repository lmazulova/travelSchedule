import SwiftUI

struct StationSelectionView: View {
    private let iconSize: Double = 24
    private let rowHeight: Double = 60
    
    @StateObject var viewModel: SelectionViewModel
    @Binding var path: NavigationPath
    
    init(viewModel: SelectionViewModel, path: Binding<NavigationPath>) {
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
                CustomSearchBar(searchText: $viewModel.searchStationText)
                
                if !viewModel.filteredStations.isEmpty {
                    List(viewModel.filteredStations, id: \.code) { station in
                        HStack {
                            Text(station.title)
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
                            viewModel.selectStation(station)
                            path.removeLast(path.count)
                        }
                    }
                    .listStyle(.plain)
                } else {
                    Spacer()
                    Text("Станция не найдена")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(Color.customBlack)
                    Spacer()
                }
            }
            .navigationTitle("Выбор станции")
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
    }
}

//#Preview {
//    StationSelectionView()
//}

