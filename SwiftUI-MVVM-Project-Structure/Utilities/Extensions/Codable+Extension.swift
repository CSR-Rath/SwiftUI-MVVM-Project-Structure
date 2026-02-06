//
//  Codable+Extension.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Design_PC on 28/1/26.
//

internal import Foundation

extension Encodable {
    
    func toData() throws -> Data {
        try JSONEncoder().encode(self)
    }
}
