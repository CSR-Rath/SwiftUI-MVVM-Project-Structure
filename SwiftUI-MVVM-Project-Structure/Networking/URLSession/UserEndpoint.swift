//
//  UserEndpoint.swift
//  iosApp
//
//  Created by Chhan Sophearath on 28/1/26.
//

import UIKit

enum UserEndpoint: APIConfiguration {
    case login(credentials: Data)
    case getPublicNews(page: Int, limit: Int, type: String?)
    case updateProfile
    case fetchProfile
    case posts
    case comments
    case albums
    case photos
    case myAPILogin
    case myAPIRefresh
    case myAPIProfile
    
    var path: String {
        switch self {
        case .login: return "/login"
        case .fetchProfile: return "/users"
        case .updateProfile: return "/update/users"
        case .getPublicNews: return "/news"
            
        // ------
        case .posts: return "/posts"
        case .comments: return "/comments"
        case .albums: return "/albums"
        case .photos: return "/photos"
            
            
         // ---- MY API ---
        case .myAPILogin: return "login"
        case .myAPIRefresh: return "refresh"
        case .myAPIProfile: return "profile"
            
        }
    }
    
    // Handle method for case endpoins
    var method: HTTPMethods {
        switch self {
        case .login, .myAPILogin:
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
        case .login, .myAPILogin:
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

