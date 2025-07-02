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
    @Published var code: String = ""
    @Published var isLoading: Bool = false
    @Published var errorType: ErrorViewType?
    @Published var carrierInfo: CarrierInfo?
    
    init() {
        self.carrierInfoService = CarrierInfoService()
    }
    
    func setCarrierCode(_ code: String) {
        //не придумала как здесь вызвать метод getCarrierInfo из .task у view, ведь может возникнуть ситуация,
        //когда code будет передан позднее, чем вызовется метод getCarrierInfo
        self.code = code
        Task {
            isLoading = true
            await getCarrierInfo()
            isLoading = false
        }
    }
    
    func getCarrierInfo() async {
        do {
            let info = try await carrierInfoService.getCarrierInfo(code: code)
            carrierInfo = info
        } catch let error as ErrorViewType {
            errorType = error
        } catch {
            errorType = .serverError
        }
    }
}
