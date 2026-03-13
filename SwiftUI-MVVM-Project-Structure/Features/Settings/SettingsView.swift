//
//  SettingsView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 28/1/26.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage(AppStorageKey.appTheme) private var appTheme: AppTheme = .system
    
    var body: some View {
        ZStack{
            Picker("Appearance", selection: $appTheme) {
                Text("System").tag(AppTheme.system)
                Text("Light").tag(AppTheme.light)
                Text("Dark").tag(AppTheme.dark)
            }
            .pickerStyle(.segmented)
            .padding()
        }
    }
    
}
