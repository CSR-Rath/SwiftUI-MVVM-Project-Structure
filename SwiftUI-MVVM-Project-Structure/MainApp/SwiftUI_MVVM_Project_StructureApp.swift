//
//  SwiftUI_MVVM_Project_StructureApp.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 28/11/25.
//

import SwiftUI
internal import Combine

@main
struct SwiftUI_MVVM_Project_StructureApp: App {
    
    /// allow woring witth appDelegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    
    @StateObject private var appState = NavigationRouter()
    @StateObject private var languageManager = LanguageManager.shared
    @AppStorage("appTheme") private var appTheme: AppTheme = .system
    
    
    init() {
        setUINavigationBarAppearance()
    }
    
    
    var body: some Scene {
        WindowGroup {
            
            RootView()
                .environmentObject(appState)
                .environmentObject(languageManager)
                .preferredColorScheme(colorScheme)
                .onOpenURL { url in
                    DeepLinkManager.shared.handle(url: url, router: appState)
                }
                .onAppear(){
                    appDelegate.appState = appState
                    
                    
                    runAll()
                    
                    
                }
            
        }
    }
    
    private func runAll() {
           
           // MARK: - Currency
           
        let amount: Double = 9259.01
           let negativeAmount: Double = -100.75
           
           print("----- Currency -----")
           print("USD:", amount.toCurrencyAsUSD)          // USD 9,259.18
           print("KHR:", amount.toCurrencyAsKHR)          // KHR 9,259 (depending on fraction config)
           print("Custom USD:", amount.toCurrency(.usd))
           print("No Symbol:", amount.toCurrency)          // 9,259.18
           print("Negative:", negativeAmount.toCurrencyAsUSD) // USD 0
           
           
           // MARK: - Fuel
           
           let fuel1: Double = 2
           let fuel2: Double = 2.567
           let fuel3: Double = 1
           
           print("\n----- Fuel -----")
           print("Fuel 2:", fuel1.toAsLitter)     // 2 Liters
           print("Fuel 2.567:", fuel2.toAsLitter) // 2.56 Liters (floor)
           print("Fuel 1:", fuel3.toAsLitter)     // 1 Liter
           print("Fuel No Unit:", fuel2.toNoLitter) // 2.56
           
           
           // MARK: - Points
           
           let point1: Double = 1
           let point2: Double = 5.678
           let point3: Double = 10.456
           
           print("\n----- Points -----")
           print("Point 1:", point1.toAsPoint)    // 1 Point
           print("Point 5.678:", point2.toAsPoint) // 5.68 Points (halfUp)
           print("Point No Label:", point3.toPoint) // 10.46
       }
    
    private var colorScheme: ColorScheme? {
           switch appTheme {
           case .system:
               return nil   // Follow system
           case .light:
               return .light
           case .dark:
               return .dark
           }
       }
}

extension SwiftUI_MVVM_Project_StructureApp{
    
    
    
    private func setUINavigationBarAppearance(){
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.configureWithOpaqueBackground()
        scrollEdgeAppearance.backgroundColor = UIColor.clear
        scrollEdgeAppearance.shadowColor = .clear // line color
        
        
        scrollEdgeAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.modelcolor
        ]
        
        scrollEdgeAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.modelcolor
        ]
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = UIColor.white
        standardAppearance.shadowColor = .gray.withAlphaComponent(0.5)
        
        standardAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.modelcolor
        ]
        
        standardAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.modelcolor
        ]
        
        UINavigationBar.appearance().standardAppearance = standardAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = scrollEdgeAppearance
    }
}
