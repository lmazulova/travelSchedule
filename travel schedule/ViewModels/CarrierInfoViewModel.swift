//
//  CarrierInfoViewModel.swift
//  travel schedule
//
//  Created by user on 29.06.2025.
//

import SwiftUI

@MainActor
final class CarrierInfoViewModel: ObservableObject {
    private let carrierInfoService: CarrierInfoServiceProtocol
    let code: String = "112"
    @Published var isLoading: Bool = false
    @Published var errorType: ErrorViewType?
    @Published var carrierInfo: CarrierInfo?
    
    init() {
        self.carrierInfoService = CarrierInfoService()
    }
    
    func getCarrierInfo() async {
        isLoading = true
        do {
            let info = try await carrierInfoService.getCarrierInfo(code: code)
            carrierInfo = info
        } catch let error as ErrorViewType {
            errorType = error
        } catch {
            errorType = .serverError
        }
        
        isLoading = false
    }
}
