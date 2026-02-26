//
//  CustomerViewModel.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 23/2/26.
//


import SwiftUI
internal import Combine

@MainActor
final class CustomerViewModel: ObservableObject {
    
    @Published var customers: [CustomerModel] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private var page = 1
    private var canLoadMore = true
    private let size = 10
    
    // MARK: - Pagination Trigger
    func loadMoreIfNeeded(currentItem: CustomerModel) {
        guard canLoadMore,
              let last = customers.last,
              last.id == currentItem.id
        else { return }
        
        Task {
            await fetchCustomers(status: .loadingMore)
        }
    }
    
    func fetchCustomers(status: ListStateEnum = .firstPage) async {
        
        if status == .refreshing {
            page = 1
            canLoadMore = true
        }else if status == .firstPage {
            isLoading = true
        }
        
        defer {
            isLoading = false
        }
        
        do {
            
            let newItems: [CustomerModel] = try await ApiManager.shared.request(
                UserEndpoint.posts(page: page, size: size)
            )
            
            if status == .refreshing {
                customers = newItems
            } else {
                customers.append(contentsOf: newItems)
            }
            
            canLoadMore = newItems.count == size
            if canLoadMore { page += 1 }
            
        }catch {
            errorMessage = error.localizedDescription
            print("Error:", error)
        }
    }
}
