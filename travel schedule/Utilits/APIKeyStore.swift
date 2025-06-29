//
//  APIKeyStore.swift
//  travel schedule
//
//  Created by user on 29.06.2025.
//

import Foundation
import SwiftKeychainWrapper

final class APIKeyStore {
    static let shared = APIKeyStore()
    private let key = "apiKey"
    
    private init() {
    }
    
    func saveAPIKey(_ apiKey: String) {
        if KeychainWrapper.standard.string(forKey: key) != nil {
            deleteAPIKey()
        }
        let isSuccess = KeychainWrapper.standard.set(apiKey, forKey: key)
        if !isSuccess {
            print("Failed to save API key to Keychain")
        }
    }
    
    func getAPIKey() -> String {
        guard let apiKey = KeychainWrapper.standard.string(forKey: key) else {
            print("API key not found in Keychain")
            return ""
        }
        return apiKey
    }
    
    func deleteAPIKey() {
        let removeSuccessful: Bool = KeychainWrapper.standard.removeObject(forKey: key)
        
        if !removeSuccessful {
            print("Failed to delete API key from Keychain")
        }
    }
}
