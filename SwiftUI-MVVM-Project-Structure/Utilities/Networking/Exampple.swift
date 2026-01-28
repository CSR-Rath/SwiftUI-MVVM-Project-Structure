//
//  Exampple.swift
//  iosApp
//
//  Created by Design_PC on 28/1/26.
//

import UIKit

struct Exampple: Codable{
    let response : Int?
}


struct Login: Codable{
    let phone: String?
    let password: String?
}

struct UserTest: Codable{
    let name: String?
    let age: Int?
    let token: String?
}




func login() async {
    do {
        
        let request = Login(phone: "0987654", password: "09876")
        let response: UserTest = try await ApiManager.shared.request(
            UserEndpoint.login(credentials: request.toData())
        )
        
    } catch {
        print("Login failed:", error)
    }
}
