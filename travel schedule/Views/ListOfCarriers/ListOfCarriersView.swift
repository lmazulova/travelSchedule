import SwiftUI

struct ListOfCarriersView: View {
    private let title: String
    @Binding var path: NavigationPath
    @StateObject var viewModel: ListOfCarriersViewModel
    
    init(title: String, path: Binding<NavigationPath>, viewModel: ListOfCarriersViewModel) {
        self.title = title
        self._path = path
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color.customWhite
                .ignoresSafeArea()
            
            VStack {
                Text(title)
                    .font(.system(size: 24, weight: .bold))
                    .multilineTextAlignment(.leading)
                    .padding(16)
                
                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                        .scaleEffect(1.5)
                    Spacer()
                } else if let error = viewModel.errorType {
                    ErrorView(errorType: error)
                } else if viewModel.filteredTrainServices.isEmpty {
                    Spacer()
                    Text("Не смогли найти подходящие рейсы для вас :(")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(Color.customBlack)
                        .multilineTextAlignment(.center)
                    Spacer()
                } else {
                    List(viewModel.filteredTrainServices) { service in
                        CarrierRow(serviceInfo: service)
                            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16))
                            .listRowSeparator(.hidden)
                            .background(.customWhite)
                            .onTapGesture {
                                viewModel.selectCarrier(with: service.carrierCode)
                                path.append(Destination.carrierInfo)
                            }
                    }
                    .listStyle(.plain)
                }
                if !viewModel.allTrainServices.isEmpty {
                    Button(action: {
                        path.append(Destination.filter)
                    }) {
                        HStack(spacing: 4) {
                            Text("Уточнить время")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.white)
                            if !viewModel.filterViewModel.isTransfer || !viewModel.filterViewModel.selectedTime.isEmpty {
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
        .task {
            await viewModel.fetchAllTrainServices()
        }
    }
}

#Preview {
    //    ListOfCarriersView(title: "Москва (Ярославский вокзал) → Санкт Петербург (Балтийский вокзал)")
}
