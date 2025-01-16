//
//  String+Ext.swift
//  AlarmtekDemo
//
//  Created by Pratik Zora on 01/11/24.
//

import Foundation

extension String {
    func refinedQR() -> String {
        let components = self
            .components(separatedBy: ";")
            .map { $0.split(separator: "=").last ?? "" }
            .joined()
        
        return components
    }
}
