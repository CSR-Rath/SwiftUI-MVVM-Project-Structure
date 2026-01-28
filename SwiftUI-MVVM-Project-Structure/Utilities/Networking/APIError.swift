//
//  APIError.swift
//  iosApp
//
//  Created by Design_PC on 28/1/26.
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
