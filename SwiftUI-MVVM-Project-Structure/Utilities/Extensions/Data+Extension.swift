//
//  Data+Extension.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 28/1/26.
//

internal import Foundation

extension Data {
    func prettyPrintedJSON() {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: self)
            let prettyData = try JSONSerialization.data(
                withJSONObject: jsonObject,
                options: [.prettyPrinted]
            )
            let prettyString = String(data: prettyData, encoding: .utf8)
            print(prettyString ?? "Invalid JSON string")
        } catch {
            print("Invalid JSON")
        }
    }
}
