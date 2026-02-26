//
//  CustomerListView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 23/2/26.
//

import SwiftUI

struct CustomerListView: View {
    
    @StateObject private var vm = CustomerViewModel()
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1)
                .ignoresSafeArea()
            
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(vm.customers) { customer in
                        CustomerCardView(customer: customer)
                            .onAppear {
                                vm.loadMoreIfNeeded(currentItem: customer)
                            }
                    }
                }
            }
            
            if vm.isLoading{
                LoadingView()
            }
        }
        .refreshable {
            await vm.fetchCustomers(status: .refreshing)
        }
        .task {
            await vm.fetchCustomers()
        }
        .navigationTitle("Customers")
    }
}
