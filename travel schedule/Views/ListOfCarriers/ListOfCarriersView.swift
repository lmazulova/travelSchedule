import SwiftUI

struct ListOfCarriersView: View {
    private let title: String
    @StateObject var viewModel = SelectionDataViewModelMock()
    @Binding var path: NavigationPath
    @ObservedObject var filterViewModel: FilterViewModel
    
    init(title: String, path: Binding<NavigationPath>, filterViewModel: FilterViewModel) {
        self.title = title
        self._path = path
        self._filterViewModel = ObservedObject(wrappedValue: filterViewModel)
    }
    var body: some View {
        ZStack {
            Color.customWhite
                .ignoresSafeArea()
            
            VStack {
                Text(title)
                    .font(.system(size: 24, weight: .bold))
                    .padding(16)
                
                List(viewModel.foundRoutes) { service in
                    CarrierRow(serviceInfo: service)
                        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16))
                        .listRowSeparator(.hidden)
                        .background(.customWhite)
                        .onTapGesture {
                            path.append(Destination.carrierInfo)
                        }
                }
                .listStyle(.plain)
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
                
                if !viewModel.foundRoutes.isEmpty {
                    Button(action: {
                        path.append(Destination.filter)
                    }) {
                        HStack(spacing: 4) {
                            Text("Уточнить время")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.white)
                            if filterViewModel.isTransfer || !filterViewModel.selectedTime.isEmpty {
                                Circle()
                                    .fill(Color.customRed)
                                    .frame(width: 8, height: 8)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.customBlue)
                        .clipShape(.rect(cornerRadius: 16))
                        
                    }
                    .frame(height: 60)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
                    .padding(.top, 0)
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    //    ListOfCarriersView(title: "Москва (Ярославский вокзал) → Санкт Петербург (Балтийский вокзал)")
}
