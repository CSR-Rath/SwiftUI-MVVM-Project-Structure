//
//  Codable+Extension.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 28/1/26.
//

internal import Foundation

extension Encodable {
 
    func toData() -> Data? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted   // make it nice format
        do {
            let data = try encoder.encode(self)
            return data
        }catch{
            debugLog("Error toData: \(error)")
            return nil
        }
    }
    
    func toJSONString() -> String? {
        do {
            let data = try JSONEncoder().encode(self)
            return String(data: data, encoding: .utf8)
        } catch {
            debugLog("Error toJSONString: \(error)")
            return nil
        }
    }
}
