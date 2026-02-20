//
//  Exampple.swift
//  iosApp
//
//  Created by Chhan Sophearath on 28/1/26.
//

import UIKit
internal import Combine
import SwiftUI

struct Example: Codable{
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
        
        print("response: \(response)")
        
    } catch {
        print("Login failed:", error)
    }
}




struct PostModel: Codable{}
struct User: Codable{}
struct Phone: Codable{}

enum LoadResult {
    case posts([PostModel])
    case users([User])
    case phones([Phone])
}

@MainActor // update UI
class SyncWaitingAllCompletedViewModel: ObservableObject {
    
    
    //    .task {
    //               await vm.asyncCall()
    //           }
    @Published var posts1: [PostModel]?
    @Published var posts2: [PostModel]?
    @Published var posts3: [PostModel]?
    
    func asyncCall() async throws {
        
        //        These start at the same time (parallel execution)
        async let p1: [PostModel] = ApiManager.shared.request(UserEndpoint.fetchProfile)
        async let p2: [PostModel] = ApiManager.shared.request(UserEndpoint.fetchProfile)
        async let p3: [PostModel] = ApiManager.shared.request(UserEndpoint.fetchProfile)
        
        //        This line waits until ALL requests complete
        let (posts1, posts2, posts3) = try await (p1, p2, p3)
        
        self.posts1 = posts1
        self.posts2 = posts2
        self.posts3 = posts3
    }
}

@MainActor // update UI
class SyncViewModel: ObservableObject {
    
    //    .task {
    //              await vm.asyncCall()
    //           }
    @Published var posts1: [PostModel]?
    @Published var posts2: [User]?
    @Published var posts3: [Phone]?
    
    func asyncCall() async {
        do {
            try await withThrowingTaskGroup(of: LoadResult.self) { group in
                
                group.addTask {
                    .posts(try await ApiManager.shared.request(UserEndpoint.fetchProfile))
                }
                
                group.addTask {
                    .users(try await ApiManager.shared.request(UserEndpoint.fetchProfile))
                }
                
                group.addTask {
                    .phones(try await ApiManager.shared.request(UserEndpoint.fetchProfile))
                }
                
                for try await result in group {
                    switch result {
                    case .posts(let posts):
                        self.posts1 = posts
                    case .users(let users):
                        self.posts2 = users
                    case .phones(let phones):
                        self.posts3 = phones
                    }
                }
            }
        } catch {
            print("TaskGroup error:", error)
        }
    }
}

@MainActor // update UI
class AwaitViewModel: ObservableObject {
    //    .task {
    //               await vm.awaitCall()
    //           }
    
    @Published var posts1: [PostModel]?
    @Published var posts2: [PostModel]?
    @Published var posts3: [PostModel]?
    
    func awaitCall() async {
        do {
            
            // |---- p1 ----|---- p2 ----|---- p3 ----|
            
            // Request 1 → wait → done
            let p1: [PostModel] = try await ApiManager.shared.request(UserEndpoint.fetchProfile)
            // Request 2 → wait → done
            let p2: [PostModel]  = try await ApiManager.shared.request(UserEndpoint.fetchProfile)
            // Request 3 → wait → done
            let p3: [PostModel] = try await ApiManager.shared.request(UserEndpoint.fetchProfile)
            
            self.posts1 = p1
            self.posts2 = p2
            self.posts3 = p3
            
        } catch {
            print("Error fetching data:", error.localizedDescription)
        }
        
    }
}


class HowtoCall{
    
    @StateObject var awaitViewModel = AwaitViewModel()
    @StateObject var syncViewModel = SyncViewModel()
    @StateObject var syncWaitingAllCompletedViewModel = SyncWaitingAllCompletedViewModel()
    
}
