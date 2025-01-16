//
//  ParametersConvertible.swift
//  SwiftNetworkLayer
//
//  Created by Gaurang Vyas on 30/01/22.
//

import Foundation

protocol ParameterConvertible {
    func urlEncoding(url: URL) throws -> URL
    func jsonData() throws -> Data
}
