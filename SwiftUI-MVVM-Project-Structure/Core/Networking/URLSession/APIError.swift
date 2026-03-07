//
//  APIError.swift
//  iosApp
//
//  Created by Chhan Sophearath on 28/1/26.
//

import SwiftUI

enum APIError: Error {
    case invalidURL
    case noInternet
    case unauthorized // 401
    case serverError(Int)
    case decodingFailed
    case sslPinningFailed
}

extension APIError: LocalizedError {
    
    var errorDescriptionFromAPIManager: String? {
        switch self {
        case .invalidURL:
            return "Invalid request URL."
            
        case .noInternet:
            return "No internet connection. Please check your network."
        case .unauthorized:
            return "Session expired. Please login again."
            
        case .serverError(let code):
            return "Internal server error \(code). Please try again later."
            
        case .decodingFailed:
            return "Failed to process server response."
            
        case .sslPinningFailed:
            return "Secure connection failed."
        }
    }
}
