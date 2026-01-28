//
//  APIConfiguration.swift
//  iosApp
//
//  Created by Design_PC on 28/1/26.
//

import SwiftUI

protocol APIConfiguration {
    var version: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var body: Data? { get }
    var queryItems: [URLQueryItem]? { get }
    var requiresAuth: Bool { get }
}
