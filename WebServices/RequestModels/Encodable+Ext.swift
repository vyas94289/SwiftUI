//
//  Convertable.swift
//  Populaw
//
//  Created by Gaurang on 22/10/21.
//

import Foundation

extension Encodable {
    // implement convert Struct or Class to Dictionary
    func convertToDict() throws -> [String: Any] {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
        if let dict = result as? [String: Any] {
            return dict
        } else {
            throw ApiError.requestModelError("Failed to convert json object into [String: String]")
        }
    }

    func jsonData() throws -> Data {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        return data
    }

    func percentageEncodedData() throws -> Data {
        let dict = try convertToDict()
        return dict.percentEncoded()!
    }
    
    func getData() -> Data? {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            return data
        } catch {
            print("Error while encoding \(Self.self)", error)
            return nil
        }
        
    }
}

extension Dictionary where Key == String, Value == Any {
    
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
    
    func urlEncoding(url: URL) throws -> URL {
        let urlStr = url.absoluteString
        var urlComponents = URLComponents(string: urlStr)!
        if !self.isEmpty {
            urlComponents.queryItems = self.compactMap {
                URLQueryItem(name: $0.key, value: String(describing: $0.value))
            }
        }
        if let finalURL = urlComponents.url {
            return finalURL
        } else {
            throw (ApiError.urlBuildingError("Error occurs during building url components - \(urlStr)"))
        }
    }
    
    func jsonEncodedData() throws -> Data {
        try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
}

extension Data {
    
    func getDecodableObject<T: Decodable>() -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: self)
        } catch {
            print("Error while decoding \(Self.self)", error)
            return nil
        }
    }
}
