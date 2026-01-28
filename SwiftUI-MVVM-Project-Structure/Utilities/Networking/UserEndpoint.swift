//
//  UserEndpoint.swift
//  iosApp
//
//  Created by Design_PC on 28/1/26.
//

import UIKit

enum UserEndpoint: APIConfiguration {
    case login(credentials: Data)
    case getPublicNews(page: Int, limit: Int, type: String?)
    case updateProfile
    case fetchProfile
    
    var version: String { "/api/v1" }
    
    var path: String {
        switch self {
        case .login: return "/login"
        case .fetchProfile: return "/users"
        case .updateProfile: return "/update/users"
        case .getPublicNews: return "/news"
        }
    }
    
    // Handle method for case endpoins
    var method: HTTPMethod {
        switch self {
        case .login:
            return .POST
        case .updateProfile:
            return .PUT
        default:
            return .GET
        }
    }
    
    // Handle header has or has no
    var requiresAuth: Bool {
        switch self {
        case .login:
            return false
        default:
            return true
        }
    }
    
    var body: Data? {
        switch self {
        case .login(let credentials):
            return credentials
        default:
            return nil
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getPublicNews(let page, let limit, let type):
            var items: [URLQueryItem] = [
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "limit", value: String(limit))
            ]
            
            if let type, !type.isEmpty {
                items.append(URLQueryItem(name: "type", value: type))
            }
            return items
            
        default:
            return nil
        }
    }
}
