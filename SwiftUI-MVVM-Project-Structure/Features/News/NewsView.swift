//
//  NewsView.swift
//  SwiftUI-MVVM-Project-Structure
//
//  Created by Chhan Sophearath on 27/2/26.
//

import SwiftUI

struct NewsView: View {
    @EnvironmentObject var appState: NavigationRouter
    
    
    let files: [FileItem] = [
        
        FileItem(fileName: "1", appRouteType: .baseTextField),
        FileItem(fileName: "2", appRouteType: .baseTextField),
        FileItem(fileName: "3", appRouteType: .baseTextField),
        FileItem(fileName: "4", appRouteType: .baseTextField),
        FileItem(fileName: "5", appRouteType: .baseTextField),

    ]
    
    var body: some View {
        
        List(files) { file in
            HStack {
                Text(file.fileName)
                    .font(.headline)
                Spacer()
            }
            .onTapGesture {
                print("Tapped: \(file.fileName)")
            }
        }
        .navigationTitle("News")
    }
    
}

struct FileItem: Identifiable {
    let id = UUID()
    let fileName: String
    let appRouteType: AppRouteType
}
