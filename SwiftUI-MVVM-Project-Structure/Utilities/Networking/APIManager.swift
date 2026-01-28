//
//  APIManager.swift
//  iosApp
//
//  Created by Design_PC on 28/1/26.
//

import Foundation
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
        
        guard let baseURLString = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String,
              var components = URLComponents(string: baseURLString) else {
            throw APIError.invalidURL
        }
        
        components.path = config.version + config.path
        components.queryItems = config.queryItems
       
        guard let url = components.url else { throw APIError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = config.method.rawValue
        request.httpBody = config.body

        
        //MARK: Hander request api
        var headers: [String: String] = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        if config.requiresAuth {
            headers["Authorization"] = "Bearer \("")"
        }
        
        request.allHTTPHeaderFields = headers
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.serverError(0)
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            do {
                
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw APIError.decodingFailed
            }
            
        default:
            throw APIError.serverError(httpResponse.statusCode)
        }
    }
}

