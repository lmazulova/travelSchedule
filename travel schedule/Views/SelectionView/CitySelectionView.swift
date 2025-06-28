import SwiftUI

struct CitySelectionView: View {
    private let iconSize: Double = 24
    private let rowHeight: Double = 60
    @StateObject var viewModel = SelectionDataViewModelMock()
    @Binding var selectedCity: String
    @Binding var selectedStation: String
    @Binding var path: NavigationPath
    var destination: Destination
    @State private var previousSelectedCity: String
    @State private var previousSelectedStation: String
    
    init(destination: Destination, selectedCity: Binding<String>, selectedStation: Binding<String>, path: Binding<NavigationPath>) {
        self.destination = destination
        self._selectedCity = selectedCity
        self._selectedStation = selectedStation
        self._path = path
        self._previousSelectedCity = State(initialValue: selectedCity.wrappedValue)
        self._previousSelectedStation = State(initialValue: selectedStation.wrappedValue)
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
                CustomSearchBar(searchText: $viewModel.searchText)
                
                if !viewModel.filteredCities.isEmpty {
                    List(viewModel.filteredCities, id: \.self) { city in
                        HStack {
                            Text(city)
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
                            selectedCity = city
                            path.append(destination)
                        }
                    }
                    .listStyle(.plain)
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
                        selectedCity = previousSelectedCity
                        selectedStation = previousSelectedStation
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
