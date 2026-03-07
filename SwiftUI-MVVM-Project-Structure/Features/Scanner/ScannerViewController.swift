//
//  ScannerViewController.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 5/3/26.
//

import UIKit
import AVFoundation

// MARK: - 3. UIKIT SCANNER CONTROLLER
class ScannerViewController: UIViewController {
    
    weak var delegate: ScannerDelegate?
    
    private var captureSession = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer?
    
    private var isScanning = true
    private let scannerLine = UIView()
    
    private let widthScan: CGFloat = 280
    private let heightScan: CGFloat = 280
    
    private var positionScan: CGRect {
        CGRect(
            x: (view.bounds.width - widthScan) / 2,
            y: (view.bounds.height - heightScan) / 2 - 50,
            width: widthScan,
            height: heightScan
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupScannerLine()
        checkCameraPermission()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer?.frame = view.bounds
    }
    
    // MARK: - Camera Permission
    
    private func checkCameraPermission() {
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            
        case .authorized:
            setupCamera()
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    DispatchQueue.main.async {
                        self.setupCamera()
                    }
                }
            }
            
        default:
            break
        }
        
    }
    
    // MARK: - Camera Setup
    
    private func setupCamera() {
        
        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device) else { return }
        
        if captureSession.canAddInput(input) {
            captureSession.addInput(input)
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metadataOutput) {
            
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: .main)
            metadataOutput.metadataObjectTypes = [.qr]
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = .resizeAspectFill
        
        if let previewLayer {
            view.layer.insertSublayer(previewLayer, at: 0)
        }
        
        setupOverlay()
        startSession()
    }
    
    @MainActor
    func startSession() {
        
        guard !captureSession.isRunning else { return }
        
        isScanning = true
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            
            self?.captureSession.startRunning()
            
            DispatchQueue.main.async {
                self?.startScanAnimation()
            }
        }
    }
    
    func stopSession() {
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }
    
    // MARK: - Overlay
    
    private func setupOverlay() {
        
        let overlay = UIView(frame: view.bounds)
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        let path = UIBezierPath(rect: overlay.bounds)
        let transparent = UIBezierPath(roundedRect: positionScan, cornerRadius: 20)
        
        path.append(transparent)
        path.usesEvenOddFillRule = true
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        mask.fillRule = .evenOdd
        
        overlay.layer.mask = mask
        
        view.addSubview(overlay)
    }
    
    // MARK: - Scanner Line
    
    private func setupScannerLine() {
        
        scannerLine.backgroundColor = .orange
        scannerLine.layer.cornerRadius = 2
        scannerLine.isHidden = true
        
        view.addSubview(scannerLine)
    }
    
    private func startScanAnimation() {
        
        scannerLine.isHidden = false
        
        scannerLine.frame = CGRect(
            x: positionScan.minX + 10,
            y: positionScan.minY,
            width: positionScan.width - 20,
            height: 3
        )
        
        UIView.animate(
            withDuration: 2,
            delay: 0,
            options: [.repeat, .autoreverse, .curveEaseInOut]
        ) {
            self.scannerLine.frame.origin.y = self.positionScan.maxY - 3
        }
    }
}

// MARK: - QR Detection

extension ScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(
        _ output: AVCaptureMetadataOutput,
        didOutput metadataObjects: [AVMetadataObject],
        from connection: AVCaptureConnection
    ) {
        
        guard isScanning,
              let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
              let code = metadataObject.stringValue else { return }
        
        isScanning = false
        
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        delegate?.didFindCode(code)
    }
}
