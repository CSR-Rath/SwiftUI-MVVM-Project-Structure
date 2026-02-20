//
//  Model.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 5/2/26.
//

import SwiftUI

nonisolated
struct LoginResponse: Codable {
    let message: String?
    let user: UserModel?
}

struct UserModel: Codable, Sendable{
    let id: Int?
    let name: String?
    let iat: Int?
    let exp: Int?
    let exrr: Int?
}




