//
//  Common+Ext.swift
//  Lyronel
//
//  Created by Gaurang on 21/12/22.
//

import Foundation

extension Array {
    
    var isNotEmpty: Bool {
        isEmpty == false
    }
    
}

extension Array where Element == String? {
    
    func fullNameFormat(separator: String = " ") -> String {
        return self.compactMap { $0 }.joined(separator: separator)
    }
}

extension Bundle {
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
}
