//
//  ApiError.swift
//  Movies
//
//  Created by Gaurang on 18/01/22.
//

import Foundation

enum ApiError: Error, LocalizedError {
    case requestModelError(_ message: String)
    case urlBuildingError(_ message: String)
    case decodingError(_ message: String)
    case internetUnavailable
    case requestTimeout
    case invalidResponseCode
    case sessionExpired

    var errorDescription: String? {
        switch self {
        case let .requestModelError(message):
            return message
        case let .decodingError(message):
            return message
        case .internetUnavailable:
            return Messages.networkError
        case let .urlBuildingError(message):
            return message
        case .requestTimeout:
            return Messages.requestTimeout
        case .invalidResponseCode:
            return "Something went wrong"
        case .sessionExpired:
            return Messages.sessionExpired
        }
    }

    var canRetry: Bool {
        if case .internetUnavailable = self {
            return true
        } else {
            return false
        }
    }
}

extension Error {
    func eraseToApiError() -> ApiError {
        switch self {
        case let apiError as ApiError:
            return apiError
        default:
            return .decodingError(localizedDescription)
        }
    }
}
