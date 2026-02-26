//
//  ProfileView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 28/1/26.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appState: NavigationRouter
    
    let userId: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Profile: \(userId)")
                .font(.largeTitle)
                .bold()
            
            Button("Pop (Back)") {
                appState.pop()
            }
            
            Button("Pop to Home") {
                appState.popToRoot()
            }
            
            Button("Push") {
               
            }
        }
        .padding()
        .navigationTitle("Profile")
//        .menuToolbar(appState: appState)
        //        .navigationBarBackButtonHidden(true) // hide default back button
        //        .toolbar {
        //            ToolbarItem(placement: .navigationBarLeading) {
        //                Button {
        //                    debugLog("Menu tapped")
        //                    appState.pop()
        //                } label: {
        //                    Image(systemName: "line.3.horizontal")
        //                }
        //            }
        //        }
    }
}
