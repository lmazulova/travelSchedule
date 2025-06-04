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
    
    private func change() {
        (from, to) = (to, from)
    }
    
    @Binding var path: NavigationPath
    @StateObject var filterViewModel = FilterViewModel()
    
    @State private var from: DeparturePoint = DeparturePoint(city: "", station: "")
    @State private var to: DeparturePoint = DeparturePoint(city: "", station: "")
    private var externalViewHeight: Double = 128
    private var internalViewHeight: Double = 96
    private var iconHeight: Double = 24
    private var circleHeight: Double = 36
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    var body: some View {
        ZStack {
            Color.customWhite
                .ignoresSafeArea()
            VStack {
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
                        .navigationDestination(for: Destination.self) { destination in
                            switch destination {
                            case .from:
                                CitySelectionView(destination: .stationFrom, selectedCity: $from.city, selectedStation: $from.station, path: $path)
                            case .to:
                                CitySelectionView(destination: .stationTo, selectedCity: $to.city, selectedStation: $to.station, path: $path)
                            case .stationFrom:
                                StationSelectionView(selectedCity: $from.city, selectedStation: $from.station, path: $path)
                            case .stationTo:
                                StationSelectionView(selectedCity: $to.city, selectedStation: $to.station, path: $path)
                            case .listOfCarriers:
                                ListOfCarriersView(title: "\(from.city) (\(from.station)) → \(to.city) (\(to.station))", path: $path, filterViewModel: filterViewModel)
                            case .carrierInfo:
                                CarrierInfoView(
                                    carrierInfo: CarrierInfoModel(
                                        title: "Аэрофлот",
                                        email: "callcenter@aeroflot.ru",
                                        phoneNumber: "+7 (495) 223-55-55",
                                        imageURL: URL(string: "https://yastat.net/s3/rasp/media/data/company/logo/aeroflot_logo_ru.gif")
                                    ),
                                    path: $path
                                )
                            case .filter:
                                FilterView(path: $path, filterViewModel: filterViewModel)
                            }
                        }
                        
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
                .frame(maxWidth: .infinity)
                .frame(height: externalViewHeight)
                .background(Color.customBlue)
                .clipShape(.rect(cornerRadius: 20))
                .padding(16)
                
                if from.city != "" && to.city != "" && from.station != "" && to.station != "" {
                    Button(action: {
                        path.append(Destination.listOfCarriers)
                    }) {
                        Text("Найти")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding([.top, .bottom], 20)
                            .padding([.leading, .trailing], 47.5)
                            .background(Color.customBlue)
                            .clipShape(.rect(cornerRadius: 16))
                    }
                    .frame(width: 150, height: 60)
                }
            }
        }
    }
}

//#Preview {
//    MainView()
//}
