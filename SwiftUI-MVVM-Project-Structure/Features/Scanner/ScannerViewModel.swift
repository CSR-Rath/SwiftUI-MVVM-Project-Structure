//
//  ScannerViewModel.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 5/3/26.
//

internal import Combine
import _PhotosUI_SwiftUI

// MARK: - 1. DELEGATE PROTOCOL
protocol ScannerDelegate: AnyObject {
    func didFindCode(_ code: String)
}

// MARK: - 2. VIEW MODEL (Logic & State)
@MainActor
class ScannerViewModel: ObservableObject {
    
    @Published var scannedCode: String? = nil
    
    @Published var selectedItem: PhotosPickerItem? = nil {
        didSet {
            if let selectedItem {
                Task { await detectQRFromPicker(item: selectedItem) }
            }
        }
    }
    
    @Published var isLoading = false
    
    // Error Handling
    @Published var showError = false
    @Published var errorMessage: String = ""
    
    private let ciContext = CIContext()
    
    
    func detectQRFromPicker(item: PhotosPickerItem) async {
        
        isLoading = true
        defer {
            isLoading = false
            selectedItem = nil
        }
        
        do {
            
            if let data = try await item.loadTransferable(type: Data.self),
               let image = UIImage(data: data),
               let ciImage = CIImage(image: image) {
                
                let detector = CIDetector(
                    ofType: CIDetectorTypeQRCode,
                    context: ciContext,
                    options: [CIDetectorAccuracy: CIDetectorAccuracyHigh]
                )
                
                let features = detector?.features(in: ciImage) as? [CIQRCodeFeature]
                
                if let code = features?.first?.messageString {
                    
                    scannedCode = code
                    
                    print("code: \(code)")
                    
                    
                } else {
                    
                    showScanFail("No QR Code found in this image.")
                    
                }
                
            } else {
                
                showScanFail("Invalid image selected.")
                
            }
            
        } catch {
            
            showScanFail("Failed to read image.")
            
        }
    }
    
    private func showScanFail(_ message: String) {
        errorMessage = message
        showError = true
    }
    
    func resetScanner() {
        scannedCode = nil
        selectedItem = nil
    }
}
