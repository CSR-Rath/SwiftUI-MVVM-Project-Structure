//
//  NetworkManager.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 13/2/26.
//

//import Alamofire
//internal import Foundation


//class APIManagerAlamofire {
//    
//    static let shared = APIManagerAlamofire()
//    private let baseURL = AppConfig.baseURL
//    
//    private init() {}
//    
//    
//    
//    func request<T: Codable>(_ config: APIConfiguration, retryCount: Int = 0) async throws -> T {
//        // Build URL with query items
//        var components = URLComponents(string: baseURL + config.path)!
//        if let queryItems = config.queryItems {
//            components.queryItems = queryItems
//        }
//        
//        // Create URLRequest
//        var urlRequest = URLRequest(url: components.url!)
//        urlRequest.method = config.method.rawValue
//        urlRequest.httpBody = config.body
//        urlRequest.headers = ["Content-Type": "application/json"]
//        
//        if config.requiresAuth,
//           let token = KeychainManager.read(key: .accessToken) {
//            urlRequest.headers.add(name: "Authorization", value: "Bearer \(token)")
//        }
//        
//        do {
//            // Use Alamofire to make async request
//            let dataTask = AF.request(urlRequest).serializingData()
//            let data = try await dataTask.value
//            
//            // Decode response
//            let decoded = try JSONDecoder().decode(T.self, from: data)
//            return decoded
//        } catch {
//            // Optional: Retry logic
//            if retryCount < 3 {
//                return try await request(config, retryCount: retryCount + 1)
//            }
//            throw error
//        }
//    }
//}

