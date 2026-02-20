//
//  APIManager.swift
//  iosApp
//
//  Created by Chhan Sophearath on 28/1/26.
//

internal import Foundation
import Security

final class ApiManager {
    
    static let shared = ApiManager()
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        return URLSession(configuration: config)
    }()
    
    private init() {}
    
    func request<T: Codable>(_ config: APIConfiguration, retryCount: Int = 0) async throws -> T {
        
        guard let baseURLString = Bundle.main.object(forInfoDictionaryKey: InfoKey.baseURL) as? String,
              var components = URLComponents(string: baseURLString) else {
            debugLog("❌ In valid baseURLString.")
            throw APIError.invalidURL
        }
        
        
        components.path = components.path + config.path
        components.queryItems = config.queryItems
        
        guard let url = components.url else {
            debugLog("❌ In valid URL.")
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = config.method.rawValue
        request.httpBody = config.body
        
        
        // MARK: Hander request api
        var headers: [String: String] = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        if config.requiresAuth,
           let token = TokenStorage.accessToken() {
            headers["Authorization"] = "Bearer \(token)"
        }
        
        
        request.allHTTPHeaderFields = headers
        printRequest(request)
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            debugLog("❌ Server error.")
            throw APIError.serverError(0)
        }
        
        printResponse(data: data)
        
        
        switch httpResponse.statusCode {
        case 200...299:
            
            do {
                
                return try JSONDecoder().decode(T.self, from: data)
            } catch{
                logDecodingError(error as! DecodingError, data: data)
                throw APIError.decodingFailed
            }
            
        case 401:
            
            try await TokenRefresher.shared.refreshIfNeeded {
                try await self.refreshAccessToken()
            }
            
            if retryCount < 1 {
                return try await self.request(config, retryCount: retryCount + 1)
            } else {
                TokenStorage.clear()
                throw APIError.unauthorized
            }
            
            
        default:
            throw APIError.serverError(httpResponse.statusCode)
        }
    }
    
    
    private func refreshAccessToken() async throws {
        
        guard let refreshToken = TokenStorage.refreshToken() else {
            throw APIError.unauthorized
        }
        
        let response: RefreshTokenResponse = try await request(AuthEndpoint.refreshToken(token: refreshToken))
        TokenStorage.saveAccessToken(response.accessToken)
        TokenStorage.saveRefreshToken(response.refreshToken)
    }
}

extension ApiManager{
    
    private func printRequest(_ request: URLRequest) {
        print("⬆️⬆️⬆️ API REQUEST ⬆️⬆️⬆️")
        
        if let url = request.url?.absoluteString {
            print("URL:", url)
        }
        
        if let method = request.httpMethod {
            print("Method:", method)
        }
        
        if let headers = request.allHTTPHeaderFields {
            if let auth = headers["Authorization"] {
                print("Authorization: \(auth)")
            }
        }
        
        if let body = request.httpBody {
            print(String(data: body, encoding: .utf8) ?? "")
        }
        
        debugLog("⬆️⬆️⬆️ END REQUEST ⬆️⬆️⬆️\n\n")
    }
    
    private func printResponse(data: Data) {
        debugLog("=== RESPONSE DATA ====")
        
        if let body = String(data: data, encoding: .utf8) {
            debugLog(body)
        } else {
            debugLog("Unable to decode response body")
        }
        
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
