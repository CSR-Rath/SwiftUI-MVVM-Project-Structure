////
////  NetworkManager.swift
////  SwiftUI-MVVM-Project-Structure
////
////  Created by Chhan Sophearath on 13/2/26.
////
//
////import Alamofire
//internal import Foundation
//import Alamofire
////import Foundation
//
//// MARK: - API Error Definitions
//enum APIErrorAlamofire: Error {
//    case invalidURL
//    case serverError(Int)
//    case decodingFailed
//    case unauthorized
//    case general(String)
//}
//
//// MARK: - API Configuration Protocol
//// Added Sendable conformance to the protocol
//protocol APIConfigurationAlamofire: URLRequestConvertible, Sendable {
//    var path: String { get }
//    var method: HTTPMethod { get }
//    var parameters: Parameters? { get }
//    var requiresAuth: Bool { get }
//}
//
//extension APIConfigurationAlamofire {
//    func asURLRequest() throws -> URLRequest {
//        guard let baseURLString = Bundle.main.object(forInfoDictionaryKey: InfoKey.baseURL) as? String,
//              let url = URL(string: baseURLString) else {
//            throw APIErrorAlamofire.invalidURL
//        }
//        
//        var request = URLRequest(url: url.appendingPathComponent(path))
//        request.method = method
//        
//        if method == .get {
//            request = try URLEncoding.default.encode(request, with: parameters)
//        } else {
//            request = try JSONEncoding.default.encode(request, with: parameters)
//        }
//        
//        return request
//    }
//}
//
//// MARK: - Auth Interceptor
//final class AuthInterceptor: @preconcurrency RequestInterceptor, @unchecked Sendable {
//    
//    // Removed @MainActor. Adapt runs on a background session queue.
//    @MainActor func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
//        var request = urlRequest
//        // Note: Ensure TokenStorage.accessToken() is thread-safe or Sendable
//        if let token = TokenStorage.accessToken() {
//            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        }
//        completion(.success(request))
//    }
//    
//    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
//        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
//            return completion(.doNotRetryWithError(error))
//        }
//        
//        Task {
//            do {
//                try await ApiManagerAlamofire.shared.refreshAccessToken()
//                completion(.retry)
//            } catch {
//                await TokenStorage.clear()
//                completion(.doNotRetryWithError(APIErrorAlamofire.unauthorized))
//            }
//        }
//    }
//}
//
//// MARK: - API Manager
//@MainActor
//final class ApiManagerAlamofire: Sendable {
//    static let shared = ApiManagerAlamofire()
//    
//    private let session: Session
//    
//    private init() {
//        let configuration = URLSessionConfiguration.af.default
//        configuration.timeoutIntervalForRequest = 30
//        self.session = Session(configuration: configuration, interceptor: AuthInterceptor())
//    }
//    
//    func request<T: Codable & Sendable>(_ config: APIConfigurationAlamofire) async throws -> T {
//        printRequest(config)
//        
//        let task = session.request(config)
//            .validate()
//            .serializingDecodable(T.self)
//        
//        let response = await task.response
//        
//        if let data = response.data {
//            printResponse(data: data)
//        }
//        
//        switch response.result {
//        case .success(let value):
//            return value
//        case .failure(let error):
//            if let decodingError = error.underlyingError as? DecodingError, let data = response.data {
//                logDecodingError(decodingError, data: data)
//                throw APIErrorAlamofire.decodingFailed
//            }
//            let statusCode = response.response?.statusCode ?? 0
//            throw APIErrorAlamofire.serverError(statusCode)
//        }
//    }
//    
//    func refreshAccessToken() async throws {
//        guard let refreshToken = TokenStorage.refreshToken() else {
//            throw APIErrorAlamofire.unauthorized
//        }
//        
//        let parameters = ["refreshToken": refreshToken]
//        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: InfoKey.baseURL) as? String else {
//            throw APIErrorAlamofire.invalidURL
//        }
//        let url = baseURL + "refresh"
//        
//        // Explicitly use .serializingDecodable().value for Async/Await
//        let response =  AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
//            .serializingDecodable(RefreshTokenResponseAlamofire.self)
//            .value
//        
//        TokenStorage.saveAccessToken(response.accessToken)
//        TokenStorage.saveRefreshToken(response.refreshToken)
//    }
//}
//
//// MARK: - Logging Extensions
//extension ApiManagerAlamofire {
//    private func printRequest(_ config: APIConfigurationAlamofire) {
//        print("⬆️ [API REQUEST]: \(config.method.rawValue) \(config.path)")
//    }
//    
//    private func printResponse(data: Data) {
//        if let json = String(data: data, encoding: .utf8) {
//            print("⬇️ [API RESPONSE]:\n\(json)\n")
//        }
//    }
//    
//    private func logDecodingError(_ error: DecodingError, data: Data) {
//        print("❌ [DECODING ERROR]: \(error)")
//    }
//}
//
//// MARK: - Auth Models
//// Added Sendable here to satisfy the request<T>() constraint
//@MainActor
//struct RefreshTokenResponseAlamofire: Codable, Sendable {
//    let accessToken: String
//    let refreshToken: String
//}
