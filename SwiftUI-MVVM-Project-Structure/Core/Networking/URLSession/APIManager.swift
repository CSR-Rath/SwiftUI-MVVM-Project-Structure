//
//  APIManager.swift
//  iosApp
//
//  Created by Chhan Sophearath on 28/1/26.
//

internal import Foundation
import Security
import SwiftUI

final class ApiManager {
    
    static let shared = ApiManager()
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        return URLSession(configuration: config)
    }()
    
    private init() {}
    
    func request<T: Codable>(_ config: APIConfiguration, retryCount: Int = 0) async throws -> T {
        

        guard var components = URLComponents(string: AppConfig.baseURL) else {
            debugLog("❌ Invalid components: \(AppConfig.baseURL).")
            throw APIError.invalidURL
        }
        
        
        components.path = components.path + config.path
        components.queryItems = config.queryItems
        
        guard let url = components.url else {
            debugLog("❌ In valid URL.")
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"//config.method.rawValue
        request.httpBody = config.body
        
        // MARK: Hander request api
        var headers: [String: String] = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        if config.requiresAuth,
           let token = KeychainManager.read(key: .accessToken) {
            headers["Authorization"] = "Bearer \(token)"
        }
        
        
        request.allHTTPHeaderFields = headers
     
        let (data, response) = try await session.data(for: request)
        printRequest(request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            debugLog("❌ Server error.")
            throw APIError.serverError(0)
        }
        
        printResponse(data: data)
        
        
        switch httpResponse.statusCode {
        case 200...299:
            
        
            
            do {
                return try JSONDecoder().decode(T.self, from: data)
            }  catch let decodingError as DecodingError {
                logDecodingError(decodingError, data: data)
                throw APIError.decodingFailed
            } catch {
                debugLog("Unknown decoding error: \(error)")
                throw APIError.decodingFailed
            }
            
        case 401:
            
            try await TokenRefresher.shared.refreshIfNeeded {
                try await self.refreshAccessToken()
            }
            
            if retryCount < 1 {
                return try await self.request(config, retryCount: retryCount + 1)
            } else {

                KeychainManager.delete(key: KeychainKeyEnum.accessToken)
                KeychainManager.delete(key: KeychainKeyEnum.refreshToken)
                // Obverver when refresh fail
                SessionManager.shared.expireSession()
                throw APIError.unauthorized
            }
            
        default:
            throw APIError.serverError(httpResponse.statusCode)
        }
    }
    
    
    private func refreshAccessToken() async throws {
        
        guard let refreshToken = KeychainManager.read(key: .refreshToken) else {
            throw APIError.unauthorized
        }
        
        let response: RefreshTokenResponse = try await request(AuthEndpoint.refreshToken(token: refreshToken))
        
        KeychainManager.save(key: .accessToken, value: response.accessToken)
        KeychainManager.save(key: .refreshToken, value: response.refreshToken)
    }
}

extension ApiManager{
    
    private func printRequest(_ request: URLRequest) {
        debugLog("⬆️⬆️⬆️ API REQUEST ⬆️⬆️⬆️")
        
        if let url = request.url?.absoluteString {
            debugLog("URL: \(url)")
        }
        
        if let method = request.httpMethod {
            debugLog("Method: \(method)")
        }
        
        if let headers = request.allHTTPHeaderFields {
            if let auth = headers["Authorization"] {
                debugLog("Authorization: \(auth)")
            }
        }
        
        if let body = request.httpBody {
            debugLog("Body: \(body.toJSONString() ?? "-")")
        }
        
        debugLog("⬆️⬆️⬆️ END REQUEST ⬆️⬆️⬆️\n\n")
    }
    
    private func printResponse(data: Data) {
        debugLog("=== RESPONSE DATA ====")

        debugLog(data.toJSONString() ?? "")
        
        debugLog("=== END RESPONSE DATA ====\n\n")
    }
    
    
    private func logDecodingError(_ error: DecodingError, data: Data) {
        
        switch error {
        case .keyNotFound(let key, let context):
            debugLog("""
            ❌ Decoding Error: Key not found
            - Key: \(key.stringValue)
            - Path: \(context.codingPath.map { $0.stringValue }.joined(separator: " → "))
            - Description: \(context.debugDescription)
            """)
            
        case .typeMismatch(let type, let context):
            debugLog("""
            ❌ Decoding Error: Type mismatch
            - Expected type: \(type)
            - Path: \(context.codingPath.map { $0.stringValue }.joined(separator: " → "))
            - Description: \(context.debugDescription)
            """)
            
        case .valueNotFound(let type, let context):
            debugLog("""
            ❌ Decoding Error: Value not found
            - Type: \(type)
            - Path: \(context.codingPath.map { $0.stringValue }.joined(separator: " → "))
            - Description: \(context.debugDescription)
            """)
            
        case .dataCorrupted(let context):
            debugLog("""
            ❌ Decoding Error: Data corrupted
            - Path: \(context.codingPath.map { $0.stringValue }.joined(separator: " → "))
            - Description: \(context.debugDescription)
            """)
            
        @unknown default:
            debugLog("❌ Unknown DecodingError")
        }
    }
}



// MARK: - Handle refresh token

enum AuthEndpoint: APIConfiguration {
    
    case refreshToken(token: String)
    
    var path: String { "refresh" }
    
    var method: HTTPMethods { .POST }
    
    var requiresAuth: Bool { false }
    
    var body: Data? {
        switch self {
        case .refreshToken(let token):
            let body = ["refreshToken": token]
            return try? JSONSerialization.data(withJSONObject: body)
        }
    }
    
    var queryItems: [URLQueryItem]? { nil }
}

struct RefreshTokenResponse: Codable {
    let accessToken: String
    let refreshToken: String
}


// MARK: Actor it is similarity class, but prevent multiple thead the same times
actor TokenRefresher {
    
    static let shared = TokenRefresher()
    
    private var isRefreshing = false
    private var waiters: [CheckedContinuation<Void, Error>] = []
    
    func refreshIfNeeded(
        refreshAction: @Sendable @escaping () async throws -> Void
    ) async throws {
        
        if isRefreshing {
            try await withCheckedThrowingContinuation { continuation in
                waiters.append(continuation)
            }
            return
        }
        
        isRefreshing = true
        
        do {
            try await refreshAction()
            waiters.forEach { $0.resume() }
            waiters.removeAll()
        } catch {
            waiters.forEach { $0.resume(throwing: error) }
            waiters.removeAll()
            throw error
        }
        
        isRefreshing = false
    }
}


