//
//  RootView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Design_PC on 28/1/26.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: AppStateManager

    var body: some View {
        ZStack {
            switch appState.root {
            case .auth:
                AuthRootView()
                
            case .home:
                HomeRootView()
                
            }
        }
    }
}
