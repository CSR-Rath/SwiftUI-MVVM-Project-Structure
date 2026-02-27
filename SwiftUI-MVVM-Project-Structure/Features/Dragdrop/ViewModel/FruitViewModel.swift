//
//  FruitViewModel.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 27/2/26.
//

import SwiftUI
internal import Combine


final class FruitViewModel: ObservableObject {
    
    @Published var fruits: [FruitModel] = []
    
    private let defaultFruits: [FruitModel] = [
        FruitModel(id: 1, name: "Apple"),
        FruitModel(id: 2, name: "Banana"),
        FruitModel(id: 3, name: "Orange"),
        FruitModel(id: 4, name: "Mango"),
        FruitModel(id: 5, name: "Pineapple"),
        FruitModel(id: 6, name: "Watermelon")
    ]
    
    init() {
        load()
    }
    
    // MARK: - Move
    func move(from source: IndexSet, to destination: Int) {
        fruits.move(fromOffsets: source, toOffset: destination)
        save()
    }
    
    // MARK: - Load (Smart Merge Version)
    private func load() {
        
        if let saved: [FruitModel] = UserDefaultsManager.shared
            .getCodable([FruitModel].self, for: .fruitDragDrop) {
            
            fruits = merge(saved: saved, with: defaultFruits)
            
        } else {
            fruits = defaultFruits
        }
        
        save() // ensure new items persist
    }
    
    // MARK: - Merge Logic when have new items
    private func merge(saved: [FruitModel], with defaults: [FruitModel]) -> [FruitModel] {
        
        var result = saved
        
        let savedIDs = Set(saved.map { $0.id })
        
        for item in defaults {
            if !savedIDs.contains(item.id) {
                result.append(item) // append new items at bottom
            }
        }
        
        return result
    }
    
    // MARK: - Save
    private func save() {
        UserDefaultsManager.shared
            .setCodable(fruits, for: .fruitDragDrop)
    }
}
