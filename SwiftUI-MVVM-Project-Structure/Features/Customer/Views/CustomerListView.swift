//
//  CustomerListView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 23/2/26.
//

import SwiftUI


struct CustomerListView: View {
    
    @StateObject private var vm = CustomerViewModel()
    @EnvironmentObject var appState: NavigationRouter
    
    var body: some View {
        ZStack {
            Color.bgcolor
                .ignoresSafeArea()
            
            ScrollView {
                LazyVStack(spacing: 0.2) {
                    ForEach(vm.customers) { customer in
                        CustomerCardView(customer: customer)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                appState.push(.profile(userId: "1234567890"))
                            }
                            .onAppear {
                                vm.loadMoreIfNeeded(currentItem: customer)
                            }
                    }
                }
            }
            .padding(.top, 0.2)
            .refreshable {
                await vm.fetchCustomers(status: .refreshing)
            }
            
        }
        .navigationTitle("Customers")
        .task {
            await vm.fetchCustomers()
        }
        .menuToolbar(appState: appState)
    }
}
