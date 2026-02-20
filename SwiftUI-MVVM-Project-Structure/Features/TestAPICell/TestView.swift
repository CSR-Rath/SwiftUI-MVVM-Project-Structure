//
//  TestView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 6/2/26.
//

import SwiftUI


struct PostScreen: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                
                Button {
                    Task {
                        await viewModel.login()
                    }
                } label: {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Button {
                    Task {
                        await viewModel.getMultipleProfile()
                    }
                } label: {
                    Text("Get profile")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
//                if viewModel.isLoading {
//                    ProgressView()
//                }
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }
            }
            .padding()
            .navigationTitle("Posts")
        }
    }
}
