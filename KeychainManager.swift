//
//  KeychainManager.swift
//  StrataPanel
//
//  Created by Gaurang on 05/04/23.
//

import Foundation
import Security

class KeychainManager {

    private let emailKey = "email"
    private let passwordKey = "password"

    func save(email: String, password: String) {
        guard let emailData = email.data(using: .utf8),
              let passwordData = password.data(using: .utf8) else {
            return
        }

        let emailQuery: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                         kSecAttrAccount as String: emailKey,
                                         kSecValueData as String: emailData]
        let passwordQuery: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                            kSecAttrAccount as String: passwordKey,
                                            kSecValueData as String: passwordData]

        let emailStatus = SecItemAdd(emailQuery as CFDictionary, nil)
        let passwordStatus = SecItemAdd(passwordQuery as CFDictionary, nil)

        if emailStatus != errSecSuccess || passwordStatus != errSecSuccess {
            // handle error
        }
    }

    func getEmail() -> String? {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: emailKey,
                                    kSecReturnData as String: kCFBooleanTrue as Any,
                                    kSecMatchLimit as String: kSecMatchLimitOne]

        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        guard status == errSecSuccess,
              let data = dataTypeRef as? Data,
              let email = String(data: data, encoding: .utf8) else {
            return nil
        }

        return email
    }

    func getPassword() -> String? {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: passwordKey,
                                    kSecReturnData as String: kCFBooleanTrue as Any,
                                    kSecMatchLimit as String: kSecMatchLimitOne]

        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        guard status == errSecSuccess,
              let data = dataTypeRef as? Data,
              let password = String(data: data, encoding: .utf8) else {
            return nil
        }

        return password
    }

    func delete() {
        let emailQuery: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                         kSecAttrAccount as String: emailKey]
        let passwordQuery: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                            kSecAttrAccount as String: passwordKey]

        SecItemDelete(emailQuery as CFDictionary)
        SecItemDelete(passwordQuery as CFDictionary)
    }
}
