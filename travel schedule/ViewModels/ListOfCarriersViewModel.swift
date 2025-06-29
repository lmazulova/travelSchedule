//
//  ListOfCarriersViewModel.swift
//  travel schedule
//
//  Created by user on 29.06.2025.
//

import SwiftUI

@MainActor
final class ListOfCarriersViewModel: ObservableObject {
    @ObservedObject var filterViewModel: FilterViewModel
    
    init(filterViewModel: FilterViewModel) {
        self._filterViewModel = ObservedObject(wrappedValue: filterViewModel)
    }
}
