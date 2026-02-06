//
//  ViewModel.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Design_PC on 6/2/26.
//

internal import Combine
internal import Foundation

@MainActor
final class ViewModel: ObservableObject {
    
    @Published var login: RefreshTokenResponse?
    @Published var posts1: LoginResponse?
    @Published var posts2: LoginResponse?
    @Published var posts3: LoginResponse?
    
    @Published var errorMessage: String?
    
    func login() async {
        errorMessage = nil
        
        do {
            let response: RefreshTokenResponse =
                try await ApiManager.shared.request(UserEndpoint.myAPILogin)
            
            login = response
            TokenStorage.saveAccessToken(response.accessToken)
            TokenStorage.saveRefreshToken(response.refreshToken)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func getMultipleProfile() async {
        errorMessage = nil
        
        do {
            
            
            async let p1: LoginResponse =
                ApiManager.shared.request(UserEndpoint.myAPIProfile)

            
            async let p2: LoginResponse =
                ApiManager.shared.request(UserEndpoint.myAPIProfile)

            async let p3: LoginResponse =
                ApiManager.shared.request(UserEndpoint.myAPIProfile)

            
            let (r1, r2, r3) = try await (p1, p2, p3)
            
            posts1 = r1
            posts2 = r2
            posts3 = r3
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
