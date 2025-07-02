//
//  CarrierInfoViewModel.swift
//  travel schedule
//
//  Created by user on 29.06.2025.
//

import SwiftUI

@MainActor
final class CarrierInfoViewModel: ObservableObject {
    @Published var code: String = ""
    @Published var isLoading: Bool = false
    @Published var errorType: ErrorViewType?
    @Published var carrierInfo: CarrierInfo?
    
    init() {}
    
    func setCarrierCode(_ code: String) {
        self.code = code
    }
    
    func getCarrierInfo() async {
        isLoading = true
        defer{ isLoading = false }
        
        do {
            let info = try await CarrierInfoService().getCarrierInfo(code: code)
            carrierInfo = info
            errorType = nil
        } catch let error as ErrorViewType {
            errorType = error
        } catch {
            errorType = .serverError
        }
    }
}
