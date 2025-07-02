//
//  NavigationDestinationView.swift
//  travel schedule
//
//  Created by user on 28.06.2025.
//

import SwiftUI

@MainActor @ViewBuilder
func NavigationDestinationView(
    destination: Destination,
    from: Binding<String>,
    to: Binding<String>,
    path: Binding<NavigationPath>,
    mainViewModel: MainViewModel
) -> some View {
    switch destination {
    case .from:
        CitySelectionView(path: path, destination: .stationFrom, viewModel: mainViewModel.selectionViewModel)
    case .to:
        CitySelectionView(path: path, destination: .stationTo, viewModel: mainViewModel.selectionViewModel)
    case .stationFrom:
        StationSelectionView(viewModel: mainViewModel.selectionViewModel, path: path)
    case .stationTo:
        StationSelectionView(viewModel: mainViewModel.selectionViewModel, path: path)
    case .listOfCarriers:
        ListOfCarriersView(
            title: "\(from.wrappedValue) → \(to.wrappedValue)",
            path: path,
            viewModel: mainViewModel.listOfCarriersViewModel
        )
    case .carrierInfo:
        CarrierInfoView(
            path: path,
            viewModel: mainViewModel.listOfCarriersViewModel.carrierInfoViewModel
        )
    case .filter:
        FilterView(path: path, filterViewModel: mainViewModel.listOfCarriersViewModel.filterViewModel)
    }
}
