//
//  SearchView.swift
//  FirebaseTemplate
//
//  Created by Richard Moult on 19/10/2025.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText: String = ""
    
    var list: [String] = ["a", "b", "c"]
    
    var body: some View {
        List(list, id: \.self) { item in
            Text(item)
        }
        .navigationTitle("Search")
    }
}

#Preview {
    SearchView()
}
