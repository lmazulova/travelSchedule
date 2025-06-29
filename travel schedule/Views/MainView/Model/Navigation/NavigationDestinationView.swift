//
//  NavigationDestinationView.swift
//  travel schedule
//
//  Created by user on 28.06.2025.
//

import SwiftUI

@ViewBuilder
func NavigationDestinationView(
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
        ListOfCarriersView(title: "\(from.wrappedValue.city) (\(from.wrappedValue.station)) → \(to.wrappedValue.city) (\(to.wrappedValue.station))", path: path/*, filterViewModel: filterViewModel*/)
    case .carrierInfo:
        CarrierInfoView(
            carrierInfo: CarrierInfo.mock,
            path: path
        )
    case .filter:
        FilterView(path: path, filterViewModel: filterViewModel)
    }
}
