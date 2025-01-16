//
//  JSONDecoder+Ext.swift
//  StarWar
//
//  Created by Gaurang on 27/03/23.
//

import Foundation

extension KeyedDecodingContainer {
    
    func decodeArray<T: Codable>(_ type: T.Type, forKey key: Key) -> [T] {
        if let array = try? self.decode([T].self, forKey: key) {
            return array
        } else {
            return []
        }
    }
    
    func decodeAsString(forKey key: Key) -> String {
        if let stringValue = try? self.decode(String.self, forKey: key) {
            return stringValue
        } else if let intValue = try? self.decode(Int.self, forKey: key) {
            return String(intValue)
        }  else if let doubleValue = try? self.decode(Double.self, forKey: key) {
            return String(doubleValue)
        } else {
            return ""
        }
    }
    
    func decodeAsDate(format: DateFormat, forKey key: Key) throws -> Date {
        let dateString = try self.decode(String.self, forKey: key)
        if let date = dateString.getDate(format) {
            return date
        } else {
            throw DecodingError.typeMismatch(Date.self, DecodingError.Context(codingPath: codingPath, debugDescription: "Invalid date format"))
        }
    }
    
    func decodeAsBool(forKey key: Key) -> Bool {
        if let stringValue = try? self.decode(String.self, forKey: key) {
            return stringValue == "1" || stringValue == "Y"
        } else {
            return self.decode(forKey: key, defaultValue: false)
        }
    }
    
    func decode<T: Decodable>(forKey key: Key, defaultValue: T) -> T {
        return (try? self.decode(T.self, forKey: key)) ?? defaultValue
    }
    
    func decodeAsURL(forKey key: Key) -> URL? {
        guard let urlString = try? self.decode(String.self, forKey: key) else {
            return nil
        }
        if let encodedURLString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: encodedURLString) {
            return url
        } else {
            return nil
        }
    }
}

extension String {
    var digitOnly: String {
        self.replacingOccurrences(of: "[^0-9.]", with: "", options: .regularExpression)
    }
}

struct Amount: Codable {
    let formatted: String
    let doubleValue: Double
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        var amount: Double?
        if let stringValue = try? container.decode(String.self) {
            amount = Double(stringValue.digitOnly)
        } else if let intValue = try? container.decode(Int.self) {
            amount = Double(intValue)
        } else {
            amount = try? container.decode(Double.self)
        }
        if let amount {
            formatted = amount.toCurrencyString()
            doubleValue = amount
        } else {
            throw DecodingError.typeMismatch(Amount.self, DecodingError.Context(codingPath: container.codingPath, debugDescription: "Invalid amount format"))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.doubleValue)
    }
    
    
  
}

struct AppID: Codable, Hashable, Equatable {
    let stringValue: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(stringValue)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.stringValue == rhs.stringValue
    }
    
    init(id: String) {
        stringValue = id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intValue = try? container.decode(Int.self) {
            stringValue = String(intValue)
        } else {
            stringValue = try container.decode(String.self)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.stringValue)
    }
}
