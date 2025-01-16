//
//  ApiServices.swift
//  Movies
//
//  Created by Gaurang on 18/01/22.
//

import Combine
import Foundation
import UIKit

class ApiService {
    static let shared = ApiService()
    private init() {}
    var session: URLSession?
   
    func call<T: Codable>(target: TargetType) async -> ApiResult<T> {
        guard Reachability.isConnectedToNetwork() else {
            return .failure(error: .internetUnavailable)
        }
        guard let url = target.fullUrl else {
            return .failure(error: .urlBuildingError("Something went wrong"))
        }
        var request: URLRequest!
        var timeout: Double = 60.0
        
        do {
            switch target.task {
            case .plainRequest:
                request = URLRequest(url: url)
            case let .withParameters(requestModel, encoding):
                request = try requestModel.makeRequest(withURL: url, encoding: encoding)
            case let .multipart(requestModel, files):
                let params = requestModel.parameter
                request = URLRequest(url: url)
                request.httpMethod = HttpMethod.post.rawValue
                let boundary = "Boundary-\(UUID().uuidString)"
                print(params)
                let bodyData = ApiService.createDataBody(boundary: boundary, params: params, files: files)
                request.httpBody = bodyData
                if files.count > 1 {
                    timeout = Double(files.count * 120)
                    // images * 2 minutes
                }
                let contentType = "multipart/form-data; boundary=\(boundary)"
                request.setValue(contentType, forHTTPHeaderField: "Content-Type")
                
            }
        } catch {
            return .failure(error: error.eraseToApiError())
        }
        
        request.httpMethod = target.method.rawValue
        for (key, value) in target.headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        print("********************************************")
        print("API URL: ", request.url?.absoluteString ?? "")
        print("*** Headers:", request.allHTTPHeaderFields ?? [:])
        print("*** Parameters: ", request.httpBody?.toString() ?? "")
       
        do {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForResource = timeout
            session = URLSession(configuration: configuration)
            let result = try await session!.data(for: request)
            session?.finishTasksAndInvalidate()
            session = nil
            print("Response: ", String(data: result.0, encoding: .utf8) ?? "")
            print("********************************************")
            let model = try JSONDecoder().decode(T.self, from: result.0)
            guard let httpURLResponse = result.1 as? HTTPURLResponse else {
                return .failure(error: ApiError.decodingError("Something went wrong"))
            }
            if httpURLResponse.statusCode == 200 {
                return .success(data: model)
            } else if !Self.checkSessionExpiredResponseStatus(response: httpURLResponse) {
                return .failure(error: .sessionExpired)
            } else {
                print("Data:", result.0.toString())
                let model = try JSONDecoder().decode(MessageResponse.self, from: result.0)
                return .failure(error: .decodingError(model.message))
            }
            
        } catch {
            print("Error: ", error)
            print("********************************************")
            if let error = error as? URLError,
               error.code == .timedOut {
                return .failure(error: ApiError.requestTimeout)
            } else {
                return .failure(error: error.eraseToApiError())
            }
        }
    }
 
    
    static func checkSessionExpiredResponseStatus(response: HTTPURLResponse) -> Bool {
        if response.statusCode == 401 {
            DispatchQueue.main.async {
                NotificationCenter.postCustom(.sessionExpired)
            }
            return false
        } else {
            return true
        }
    }
}

extension ApiService {
    enum ParamKey: String {
        case userId = "user_id"
        case page
        case query
        case apiKey = "api_key"
    }
    
    enum Encoding {
        case url
        case json
        case percentage
    }
}

extension ApiService {
    static func createDataBody(
        boundary: String, params: [String: Any], files: [MimeTypes]
    ) -> Data {
        let lineBreak = "\r\n"
        var body = Data()
        
        for (key, value) in params {
            body.appendString("--\(boundary)\(lineBreak)")
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak)\(lineBreak)")
            if let value = value as? String {
                body.appendString("\(value)\(lineBreak)")
            }
        }
        
        for file in files {
            body.appendString("--\(boundary)\(lineBreak)")
            body.appendString("Content-Disposition: form-data; name=\"\(file.key)\"; filename=\"\(file.fileName)\"\(lineBreak)")
            body.appendString("Content-Type: \(file.mimeType)\(lineBreak)\(lineBreak)")
            body.append(file.data)
            body.appendString(lineBreak)
        }
        
        body.appendString("--\(boundary)--\(lineBreak)")
        return body
    }

}

extension Data {
    mutating func appendString(_ string: String) {
        let data = string.data(
            using: String.Encoding.utf8)
        append(data!)
    }
}
