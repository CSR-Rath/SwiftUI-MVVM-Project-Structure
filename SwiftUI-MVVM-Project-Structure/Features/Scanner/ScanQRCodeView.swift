//
//  ScanQRCodeView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 5/3/26.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct ScanQRCodeView: View {
    
    @StateObject private var viewModel = ScannerViewModel()
    
    var body: some View {
        ZStack {
            
            ScannerView(scannedCode: $viewModel.scannedCode)
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                PhotosPicker(selection: $viewModel.selectedItem, matching: .images) {
                    
                    Image(systemName: "photo.on.rectangle")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 65, height: 65)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.white.opacity(0.3), lineWidth: 1)
                        )
                }
                .padding(.bottom, 50)
            }
        }
        
        
        .onChange(of: viewModel.scannedCode) { newValue in

            print("New Value:", newValue ?? "nil")
             
        }
        
        .alert("Scan Failed", isPresented: $viewModel.showError) {
            
            Button("OK", role: .cancel) {}
            
        } message: {
            
            Text(viewModel.errorMessage)
        }
    }
}
