//
//  SwiftUI_MVVM_Project_StructureApp.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Design_PC on 28/11/25.
//

import SwiftUI
import CoreData
internal import Combine
import GoogleMaps

@available(iOS 17.0, *)
@main
struct SwiftUI_MVVM_Project_StructureApp: App {
    @StateObject var appState = AppState()
    
        init() {
            GMSServices.provideAPIKey("AIzaSyDSXrwu6JBuY6VfJfjCcXDdOp2PqIwbGbk")
        }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
        }
    }
}


// MARK: - ROUTES
enum AppRoute {
    case login
    case home
    case profile
}

// MARK: - APP STATE
class AppState: ObservableObject {
    @Published var currentRoute: AppRoute = .login
}


// MARK: - ROOT VIEW
struct RootView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationView {
            switch appState.currentRoute {
            case .login:
                LoginView()
            case .home:
                HomeView()
            case .profile:
                ProfileView()
            }
        }
    }
}

// MARK: - LOGIN
class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""

    func login(appState: AppState) {
        if !username.isEmpty {
            appState.currentRoute = .home
        }
    }
}

struct LoginView: View {
    @StateObject var vm = LoginViewModel()
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 16) {
            Text("Login").font(.largeTitle)

            TextField("Username", text: $vm.username)
                .textFieldStyle(.roundedBorder)

            SecureField("Password", text: $vm.password)
                .textFieldStyle(.roundedBorder)

            Button("Login") {
                vm.login(appState: appState)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
    
}

// MARK: - HOME
class HomeViewModel: ObservableObject {
    @Published var title = "Home Screen"
}

struct HomeView: View {
    @StateObject var vm = HomeViewModel()
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 20) {
            Text(vm.title).font(.largeTitle)

            NavigationLink("Go to Profile") {
                ProfileView()
              
            }
            Button("Profile") {
                appState.currentRoute = .profile
            }
            .foregroundColor(.red)

            Button("Logout") {
                appState.currentRoute = .login
            }
            .foregroundColor(.red)
        }
        .padding()
    }
}

// MARK: - PROFILE
struct ProfileView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Profile Screen")
                .font(.largeTitle)
        }
    }
}
