//
//  ProfileView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 28/1/26.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appState: NavigationRouter
    
    var body: some View {
        
        VStack{
            
            Text("Profile")
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
        .navigationTitle("Profile")
//        .preferredColorScheme(.light)
    }
}
