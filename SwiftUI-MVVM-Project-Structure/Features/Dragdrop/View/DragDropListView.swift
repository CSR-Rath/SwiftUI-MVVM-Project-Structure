//
//  DragDropListView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 27/2/26.
//

import SwiftUI

import SwiftUI

struct DragDropListView: View {
    
    @StateObject private var vm = FruitViewModel()
    
    var body: some View {
        List {
            ForEach(vm.fruits) { fruit in
                HStack {
                    Text("\(fruit.id).")
                        .foregroundColor(.gray)
                    Text(fruit.name)
                }
            }
            .onMove(perform: vm.move)
        }
        .navigationTitle("Fruits")
        .toolbar {
            EditButton()
        }
        
    }
}
