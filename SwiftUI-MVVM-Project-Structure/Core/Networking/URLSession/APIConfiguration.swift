//
//  APIConfiguration.swift
//  iosApp
//
//  Created by Chhan Sophearath on 28/1/26.
//

import SwiftUI

protocol APIConfiguration {
    var path: String { get }
    var method: HTTPMethods { get }
    var body: Data? { get }
    var queryItems: [URLQueryItem]? { get }
    var requiresAuth: Bool { get }
}
