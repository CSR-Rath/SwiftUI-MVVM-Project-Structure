//
//  AppRouter.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Design_PC on 28/11/25.
//

import SwiftUI

//
//@available(iOS 16.0, *)
//struct AppRouter: View {
//    @EnvironmentObject var appState: AppState
//
//    var body: some View {
//        NavigationStack(path: $appState.path) {
//            Group {
//                if appState.isLoggedIn {
//                    HomeView()
//                } else {
//                    LoginView()
//                }
//            }
//            .navigationDestination(for: AppRoute.self) { route in
//                switch route {
//                case .home:
//                    HomeView()
//
//                case .profile(let userId):
//                    
//                    HomeView()
////                    ProfileView(userId: userId)
//
//                case .productDetail(let id, let name):
//                    
//                    HomeView()
////                    ProductDetailView(id: id, name: name)
//
//                case .settings:
//                    HomeView()
////                    SettingsView()
//                }
//            }
//        }
//    }
//}
//
//enum AppRoute: Hashable {
//    case home
//    case profile(userId: String)
//    case productDetail(id: Int, name: String)
//    case settings
//}
