//
//  Codable+Extension.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 28/1/26.
//

internal import Foundation

extension Encodable {
    
//    func toData() throws -> Data {
//        try JSONEncoder().encode(self)
//    }
    
    
    func toData() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted   // make it nice format
        
        let data = try encoder.encode(self)
        
        // Print JSON string
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Encoded JSON:")
            print(jsonString)
        }
        
        return data
    }
    
    func toJSONString() throws -> String {
         let data = try JSONEncoder().encode(self)
         let string = String(data: data, encoding: .utf8) ?? ""
         debugLog("toJSONString: |(toJSONString)")
         return string
     }
}
