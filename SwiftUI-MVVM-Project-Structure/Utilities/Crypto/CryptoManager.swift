//
//  CryptoManager.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 9/2/26.
//

internal import Foundation
import CommonCrypto

final class CryptoManager {
    
    static let shared = CryptoManager()
    private init() {}
    
    // MARK: -->  AES  =  Advanced Encryption Standard
    
    func encrypt(_ plainText: String,
                 key: String,
                 iv: String) -> String {
        
        let encrypted = plainText.aesEncrypt(
            key: key,
            iv: iv
        )
        
        let result = encrypted?.filter { !$0.isWhitespace } ?? ""
        debugLog("🔐 AES Encrypt ==> \(result)")
        return result
    }
    
    func decrypt(_ cipherText: String,
                 key: String,
                 iv: String) -> String {
        
        let decrypted = cipherText.aesDecrypt(
            key: key,
            iv: iv
        )
        
        let result = decrypted ?? ""
        debugLog("🔓 AES Decrypt ==> \(result)")
        return result
    }
    
    // MARK: --> HMAC = Hash-based Message Authentication Code
    
    func hmacSHA512(message: String, key: String) -> String {
//        Secret Key + Message + Hash Algorithm
        
        guard let keyData = key.data(using: .utf8),
              let messageData = message.data(using: .utf8) else {
            return ""
        }
        
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
        
        keyData.withUnsafeBytes { keyBytes in
            messageData.withUnsafeBytes { messageBytes in
                CCHmac(
                    CCHmacAlgorithm(kCCHmacAlgSHA512),
                    keyBytes.baseAddress,
                    keyData.count,
                    messageBytes.baseAddress,
                    messageData.count,
                    &digest
                )
            }
        }
        
        return Data(digest).base64EncodedString()
    }
}




// MARK: - Example
struct Auth: Codable {
    let phoneNumber: String
    let password: String
}

struct TransferRequest: Codable {
    var timestamp: String
    var fromAccountNumber: String
    var toAccountNumber: String
    var counterId: String
    var quantityLiter: String
    var hash: String
}

struct EncrypoitAES: Codable{
    var data: String
}



class HowToUseCryptoHelper {
    
    /// Example: Encrypt an `Auth` object
    func useEncryptionAES() {
        let user = Auth(phoneNumber: "081856090", password: "11111")
        
        guard let jsonString = try? user.toJSONString() else { return }
        
        let decrypted = CryptoManager.shared.decrypt(
            jsonString,
            key: CryptoConfig.Auth.key,
            iv: CryptoConfig.Auth.iv
        )
        
        print("decrypted: \(decrypted)")
        
        
    }
    
    /// Example: Decrypt an AES string (You must pass encrypted string from server or test)
    func useDecryptionAES(encryptedString: String) {
        
        let decrypted = CryptoManager.shared.decrypt(
            encryptedString,
            key: CryptoConfig.Auth.key,
            iv: CryptoConfig.Auth.iv,
        )
        
        guard let data = decrypted.data(using: .utf8) else { return }
        let response = try? data.decode(Auth.self)
        
        print("📦 Model ==> \(String(describing: response))")
        
        
    }
    
    /// Create encrypted transfer request with HMAC hash
    func generateTransferPayload(from request: TransferRequest) -> String {
        
        // 1️⃣ Build HMAC sequence
        let sequence =
            "\(request.timestamp)" +
            "\(request.fromAccountNumber)" +
            "\(request.toAccountNumber)" +
            "\(request.counterId)" +
            "\(request.quantityLiter)"
        
        let hash = CryptoManager.shared.hmacSHA512(
            message: sequence,
            key: CryptoConfig.Transfer.hmac
        )
        
        // 2️⃣ Add hash into request
        var updatedRequest = request
        updatedRequest.hash = hash
        
        // 3️⃣ Convert to JSON
        guard let jsonString = try? updatedRequest.toJSONString() else {
            return ""
        }
        
        // 4️⃣ Encrypt JSON
        let encryptedPayload = CryptoManager.shared.encrypt(
            jsonString,
            key: CryptoConfig.Transfer.key,
            iv: CryptoConfig.Transfer.iv
        )
        
        // 5️⃣ Return encrypted payload ✅
        return encryptedPayload
    }

    
}


extension Data {
    func decode<T: Decodable>(_ type: T.Type) throws -> T {
        try JSONDecoder().decode(T.self, from: self)
    }
}

