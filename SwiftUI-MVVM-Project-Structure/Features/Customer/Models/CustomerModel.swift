//
//  CustomerModel.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 23/2/26.
//

internal import Foundation

struct CustomerModel: Identifiable, Codable {
    let name: String?
    let email: String?
    let id: Int?
    let title: String?
    let body: String?
}
