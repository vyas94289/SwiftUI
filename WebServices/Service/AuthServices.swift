//
//  AuthServices.swift
//  StrataPanel
//
//  Created by Gaurang on 31/07/23.
//

import Foundation

enum AuthService {
    case verifyClient(client: String)
    case login(model: RequestModels.Login)
    case requestOTP(userName: String)
    case changePassword(oldPassword: String, newPassword: String)
    case logout
    case forgotPassword(username: String)
    
}

extension AuthService: TargetType {
    
    var baseURL: String {
        return Helper.apiBaseURL
    }
    
    var path: String {
        switch self {
        case .verifyClient:
            return APIPaths.verifyClient
        case .login:
            return APIPaths.login
        case .requestOTP:
            return APIPaths.requestOTP
        case .changePassword:
            return APIPaths.changePassword
        case .logout:
            return APIPaths.logout
        case .forgotPassword:
            return "forgot_password"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .logout:
            return .get
        default:
            return .post
        }
    }
    
    var headers: [String : String] {
        ClientService.shared.getApiHeaders()
    }
    
    var task: ApiTask {
        switch self {
        case .verifyClient(let client):
            return .withParameters(.init(["alias": client]), encoding: .json)
        case .login(let model):
            return .withParameters(.init(model), encoding: .json)
        case .requestOTP(let userName):
            return .withParameters(.init(["username": userName]), encoding: .json)
        case .changePassword(let oldPassword, let newPassword):
            let param = ["old_password": oldPassword, "new_password": newPassword]
            return .withParameters(.init(param), encoding: .json)
        case .logout:
            return .plainRequest
        case .forgotPassword(let userName):
            return .withParameters(.init(["username": userName]), encoding: .json)
        }
    }
    
    
}
