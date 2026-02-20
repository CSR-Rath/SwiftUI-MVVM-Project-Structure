//
//  AES+String.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 9/2/26.
//

internal import Foundation
import CommonCrypto

extension String {
    
    func aesEncrypt(key: String, iv: String) -> String? {
        
        guard let keyData = key.data(using: .utf8),
              let data = self.data(using: .utf8),
              let ivData = iv.data(using: .utf8) else {
            return nil
        }
        
        var cryptData = Data(count: data.count + kCCBlockSizeAES128)
        let cryptLength = cryptData.count
        var numBytesEncrypted: size_t = 0
        
        let status = cryptData.withUnsafeMutableBytes { cryptBytes in
            data.withUnsafeBytes { dataBytes in
                keyData.withUnsafeBytes { keyBytes in
                    ivData.withUnsafeBytes { ivBytes in
                        CCCrypt(
                            CCOperation(kCCEncrypt),
                            CCAlgorithm(kCCAlgorithmAES128),
                            CCOptions(kCCOptionPKCS7Padding),
                            keyBytes.baseAddress,
                            kCCKeySizeAES256,
                            ivBytes.baseAddress,
                            dataBytes.baseAddress,
                            data.count,
                            cryptBytes.baseAddress,
                            cryptLength,
                            &numBytesEncrypted
                        )
                    }
                }
            }
        }
        
        
        guard status == kCCSuccess else {
            print("❌ AES Encryption Failed. Status: \(status)")
            return nil
        }
        
        cryptData.removeSubrange(numBytesEncrypted..<cryptData.count)
        return cryptData.base64EncodedString()
    }
    
    func aesDecrypt(key: String, iv: String) -> String? {
        
        guard let keyData = key.data(using: .utf8),
              let data = Data(base64Encoded: self),
              let ivData = iv.data(using: .utf8) else {
            return nil
        }
        
        var cryptData = Data(count: data.count + kCCBlockSizeAES128)
        let cryptLength = cryptData.count   // ✅ copy to local constant
        var numBytesDecrypted: size_t = 0
        
        let status = cryptData.withUnsafeMutableBytes { cryptBytes in
            data.withUnsafeBytes { dataBytes in
                keyData.withUnsafeBytes { keyBytes in
                    ivData.withUnsafeBytes { ivBytes in
                        CCCrypt(
                            CCOperation(kCCDecrypt),
                            CCAlgorithm(kCCAlgorithmAES128),
                            CCOptions(kCCOptionPKCS7Padding),
                            keyBytes.baseAddress,
                            kCCKeySizeAES256,
                            ivBytes.baseAddress,
                            dataBytes.baseAddress,
                            data.count,
                            cryptBytes.baseAddress,
                            cryptLength,
                            &numBytesDecrypted
                        )
                    }
                }
            }
        }
        
        guard status == kCCSuccess else {
            print("❌ AES Decryption Failed. Status: \(status)")
            return nil
        }
        
        cryptData.removeSubrange(numBytesDecrypted..<cryptData.count)
        return String(data: cryptData, encoding: .utf8)
    }
    
}
