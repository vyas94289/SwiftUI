import Combine
import Foundation
import SwiftUI

enum AppRootScreen {
    case login
    case home
}

class ClientService: ObservableObject {
    @Published private(set) var rtspURL: URL?
    @Published private(set) var devices: [Device] = []
    @Published var tabbarVisibility: Visibility = .visible
    @Published var userProfile: UserProfile?
    @Published var appRootScreen: AppRootScreen = .login
    var username: String = ""
    var password: String = ""
    var ipAddress: String = ""
    var port: String = ""
    
    init() {
        userProfile = AppDefaults.shared.userProfile
        checkSession()
        loadCredentials()
        fetchDevices()
       // addDummyDevice()
        NotificationCenter.default.addObserver(self, selector: #selector(handleDeviceDataChanged(_:)), name: .deviceDataChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideTabBar(_:)), name: .hideTabBar, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showTabBar(_:)), name: .showTabBar, object: nil)
    }
    
    @objc private func handleDeviceDataChanged(_ notification: Notification) {
        if let updatedDevice = notification.object as? Device {
            print("Device data has changed: \(updatedDevice)")
        }
        fetchDevices()
        objectWillChange.send()
    }
    
    static func hideTabBar() {
        NotificationCenter.default.post(name: .hideTabBar, object: nil)
    }
    
    static func showTabBar() {
        NotificationCenter.default.post(name: .showTabBar, object: nil)
    }
    
    @objc private func hideTabBar(_ notification: Notification) {
        if tabbarVisibility != .hidden {
            tabbarVisibility = .hidden
        }
        
    }
    
    @objc private func showTabBar(_ notification: Notification) {
        if tabbarVisibility != .visible {
            tabbarVisibility = .visible
        }
    }
    
    func setCredentials(username: String, password: String, ipAddress: String, port: String) {
    
        AppDefaults.shared.userName = username
        AppDefaults.shared.password = password
        AppDefaults.shared.ipAddress = ipAddress
        AppDefaults.shared.port = port
        
        self.username = username
        self.password = password
        self.ipAddress = ipAddress
        self.port = port
        generateRTSPURL()
    }
    
    func deleteConnection() {
        AppDefaults.shared.userName = ""
        AppDefaults.shared.password = ""
        AppDefaults.shared.ipAddress = ""
        AppDefaults.shared.port = ""
        self.username = ""
        self.password = ""
        self.ipAddress = ""
        self.port = ""
        generateRTSPURL()
    }
    
    func doLogin(_ profile: UserProfile) {
        self.userProfile = profile
        AppDefaults.shared.userProfile = profile
        checkSession()
    }
    
    func doLogout() {
        self.userProfile = nil
        AppDefaults.shared.userProfile = nil
        checkSession()
    }
    
    func checkSession() {
        if userProfile == nil {
            self.appRootScreen = .login
        } else {
            self.appRootScreen = .home
        }
    }
    
    func loadCredentials() {
        username = AppDefaults.shared.userName
        password = AppDefaults.shared.password
        ipAddress = AppDefaults.shared.ipAddress
        port = AppDefaults.shared.port
        generateRTSPURL()
    }
    
    
    func generateRTSPURL() {
        if username.isEmpty || password.isEmpty || ipAddress.isEmpty || port.isEmpty {
            self.rtspURL = nil
        } else {
            let encodedUsername = username.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? username
            let encodedPassword = password.addingPercentEncoding(withAllowedCharacters: .urlPasswordAllowed) ?? password
            self.rtspURL = URL(string: "rtsp://\(encodedUsername):\(encodedPassword)@\(ipAddress):\(port)/videoMain")
        }
        
    }
    
    func addDummyDevice() {
        do {
            let device = Device(context: Persistence.shared.viewContext)
            device.uid = "5DVA3Q6KPLKYEPYUZZZZ7Y8M"
            device.ipAddress = "192.168.1.102"
            device.port = "88"
            device.macAddress = "A0E1BC353BE3"
            device.name = "Doorbell"
            try Persistence.shared.save()
        } catch {
            print(error)
        }
    }
    
    func fetchDevices() {
        do {
            self.devices = try Persistence.shared.fetch(Device.fetchRequest())
        } catch {
            print(error)
        }
    }
}
