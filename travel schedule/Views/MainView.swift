import SwiftUI

enum Destination: Hashable {
    case stationFrom
    case stationTo
    case from
    case to
    case listOfCarriers
    case carrierInfo
    case filter
}

struct DeparturePoint {
    var city: String
    var station: String
    
    init(city: String, station: String) {
        self.city = city
        self.station = station
    }
}

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
    
    // MARK: - Helper Views
    private struct StationsSelectionSection: View {
        // MARK: - UI Constants
        private let internalViewHeight: Double = 96
        private let iconHeight: Double = 24
        private let circleHeight: Double = 36
        
        @Binding var from: DeparturePoint
        @Binding var to: DeparturePoint
        var change: () -> Void
        
        var body: some View {
            HStack {
                HStack(spacing: 16) {
                    VStack(spacing: 28) {
                        NavigationLink(value: Destination.from) {
                            Text(from.station.isEmpty ? "Откуда" : "\(from.city) (\(from.station))")
                                .font(.system(size: 17, weight: .regular))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(from.station.isEmpty ? .customGray : .black)
                                .lineLimit(1)
                        }
                        
                        NavigationLink(value: Destination.to) {
                            Text(to.station.isEmpty ? "Куда" : "\(to.city) (\(to.station))")
                                .font(.system(size: 17, weight: .regular))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(to.station.isEmpty ? .customGray : .black)
                                .lineLimit(1)
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 13))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: internalViewHeight)
                    .background(Color.white)
                    .clipShape(.rect(cornerRadius: 20))
                    
                    Button(action: change) {
                        Image("change")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: iconHeight, height: iconHeight)
                            .background(
                                Color.white
                                    .frame(width: circleHeight, height: circleHeight)
                                    .clipShape(.circle)
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(16)
            }
            .background(Color.customBlue)
            .clipShape(.rect(cornerRadius: 20))
        }
    }
    
    private struct FindButton: View {
        private let buttonHeight: Double = 60
        private let buttonWidth: Double = 150
        
        let action: () -> Void
        var body: some View {
            Button(action: {
                action()
            }) {
                Text("Найти")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .padding([.leading, .trailing], 47.5)
                    .background(Color.customBlue)
                    .clipShape(.rect(cornerRadius: 16))
            }
            .frame(width: buttonWidth, height: buttonHeight)
        }
    }
    
    // MARK: - Navigation
    @ViewBuilder
    private func NavigationDestinationView(
        destination: Destination,
        from: Binding<DeparturePoint>,
        to: Binding<DeparturePoint>,
        path: Binding<NavigationPath>,
        filterViewModel: FilterViewModel
    ) -> some View {
        switch destination {
        case .from:
            CitySelectionView(destination: .stationFrom, selectedCity: from.city, selectedStation: from.station, path: path)
        case .to:
            CitySelectionView(destination: .stationTo, selectedCity: to.city, selectedStation: to.station, path: path)
        case .stationFrom:
            StationSelectionView( selectedCity: from.city, selectedStation: from.station, path: path)
        case .stationTo:
            StationSelectionView(selectedCity: to.city, selectedStation: to.station, path: path)
        case .listOfCarriers:
            ListOfCarriersView(title: "\(from.wrappedValue.city) (\(from.wrappedValue.station)) → \(to.wrappedValue.city) (\(to.wrappedValue.station))", path: $path, filterViewModel: filterViewModel)
        case .carrierInfo:
            CarrierInfoView(
                carrierInfo: CarrierInfo.mock,
                path: path
            )
        case .filter:
            FilterView(path: path, filterViewModel: filterViewModel)
        }
    }
    
}

//#Preview {
//    MainView()
//}


