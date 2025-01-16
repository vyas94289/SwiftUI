//
//  UserDefaultsWrapper.swift

import Foundation

private protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool {
        self == nil
    }
}

@propertyWrapper struct UserDefaultsWrapper<T> {
    let key: String
    let defaultValue: T
    let storage: UserDefaults = .standard
    
    var wrappedValue: T {
        get {
            storage.value(forKey: key) as? T ?? defaultValue
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                storage.removeObject(forKey: key)
            } else {
                storage.setValue(newValue, forKey: key)
            }
        }
    }
}

extension UserDefaultsWrapper where T: ExpressibleByNilLiteral {
    init(key: String) {
        self.init(key: key, defaultValue: nil)
    }
}

@propertyWrapper struct UserDefaultsCodableWrapper<T: Codable> {
    let key: String
    private let storage = UserDefaults.standard
    var wrappedValue: T? {
        get {
            if let data = storage.data(forKey: key) {
                
                return try? JSONDecoder().decode(T.self, from: data)
            } else {
                return nil
            }
        }
        set {
            if let newValue, let data = try? JSONEncoder().encode(newValue) {
                storage.set(data, forKey: key)
            } else {
                storage.removeObject(forKey: key)
            }
            storage.synchronize()
        }
    }
}


class AppDefaults {
    
    static var shared = AppDefaults()
    
    @UserDefaultsWrapper(key: "username", defaultValue: "")
    var userName: String
    
    @UserDefaultsWrapper(key: "password", defaultValue: "")
    var password: String
    
    @UserDefaultsWrapper(key: "ipAddress", defaultValue: "")
    var ipAddress: String
    
    @UserDefaultsWrapper(key: "port", defaultValue: "")
    var port: String
    
    @UserDefaultsCodableWrapper(key: "user_profile")
    var userProfile: UserProfile?
    
    @UserDefaultsCodableWrapper(key: "crossLine")
    var crossLine: CrossLineModel?
}
