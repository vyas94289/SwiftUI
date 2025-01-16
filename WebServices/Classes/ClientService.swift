//
//  ClientService.swift
//  StrataPanel
//
//  Created by Gaurang on 31/07/23.
//

import Foundation

class ClientService {
    private(set) var client: String = ""
    var userInfo: UserAccount?
    let xApiToken = "p-Z!A++YSwaLf8W*"
    let fcmToken = "NotificationIsNotImplementedYet"
    
    static let shared = ClientService()
    
    var role: LoginRole {
        userInfo?.role ?? .employee
    }
    
    var selectedProperty: PropertyModel?
    
    var selectedUnit: Unit? 
    
    var propertyName: String {
        if let property = selectedProperty?.name, let unitName {
            return "\(property) (\(unitName))"
        } else {
            return ""
        }
    }
    
    var unitName: String? {
        selectedUnit?.fullString
    }
    
    var currency: String {
        selectedProperty?.currency ?? ""
    }
    
    var currencySymbol: String {
        selectedProperty?.currencySymbol ?? ""
    }
    
    var razorPayKey: String {
        selectedProperty?.razorPayKeyId ?? ""
    }
    
    var bearerToken: String {
        if let token = userInfo?.token {
            return "Bearer \(token)"
        } else {
            return ""
        }
    }
    
    var visitorCompanies: VisitorCompanies?
    
    let termCondition = "https://doorjoin.com/terms-and-conditions"
    let privacyPolicy = "https://doorjoin.com/privacy-policy"
    
    private init() {
        client = AppDefaults.shared.client
        userInfo = AppDefaults.shared.userAccount
        selectedProperty = AppDefaults.shared.property
        selectedUnit = AppDefaults.shared.unit
        fetchVisitorCompanies()
    }
    
    func setClient(_ value: String) {
        AppDefaults.shared.client = value
        client = value
    }
    
    func setUserInfo(_ value: UserAccount?) {
        selectedProperty = value?.properties.first(where: {$0.units.isNotEmpty})
        selectedUnit = selectedProperty?.units.first
        savePropertyAndUnits()
        AppDefaults.shared.userAccount = value
        userInfo = value
        fetchVisitorCompanies()
    }
    
    func savePropertyAndUnits() {
        AppDefaults.shared.property = selectedProperty
        AppDefaults.shared.unit = selectedUnit
    }
    
    func getApiHeaders(isForMultipart: Bool = false) -> [String: String] {
        var info: [String: String] = [
            "x-api-token": xApiToken,
            "Accept": "application/json"
        ]
        if !isForMultipart {
            info["Content-Type"] = "application/json"
        }
        if userInfo != nil {
            info["Authorization"] = bearerToken
        }
        if let propertyID = selectedProperty?.id.stringValue,
           let unitId = selectedUnit?.id.stringValue {
            info["x-property-id"] = propertyID
            info["x-unit-id"] = unitId
        }
        return info
        
    }
    
    var appModules: [AppModule] {
        let role = userInfo?.role ?? .talent
        var modules: [AppModule] = []
        switch role {
        case .owner:
            modules = [
                .units,
                .bills,
                .documents,
                .agreement,
                .vehicle,
                .visitorList,
                .directory,
                .announcement,
                .events,
                .meetings,
                .polls
            ]
        case .talent:
            modules = [
                .units,
                .bills,
                .paymentHistory,
                .documents,
                .agreement,
                .manageVisitor,
                .visitorList,
                .events,
                .meetings
            ]
        case .employee:
            modules = [
                .visitorList,
                .visitorList,
                .addVisitor,
                .directory,
                .serviceProvider,
                .announcement,
                .vehicle,
                .meetings,
                .events
            ]
        }
        return modules
    }
    
    func isModuleExistForRole(_ module: AppModule) -> Bool {
        appModules.contains(module)
    }
    
    func fetchVisitorCompanies() {
        guard userInfo != nil else {
            return
        }
        Task { @MainActor in
            let result = await APICalls.visitorCompanies()
            switch result {
            case .success(let data):
                self.visitorCompanies = data.response
            case .failure(_):
                self.visitorCompanies = nil
            }
        }
    }
}

enum AppModule: CaseIterable {
    case units
    case bills
    case documents
    case agreement
    case vehicle
    case visitorList
    case addVisitor
    case manageVisitor
    case directory
    case announcement
    case events
    case meetings
    case polls
    case paymentHistory
    case serviceProvider
}
