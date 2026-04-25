//
//  Main.swift
//  BookBuddy
//
//  Created by Kashyap Ramachandrula on 4/25/26.
//
import SwiftUI

struct Main: View {
    var body: some View {
        VStack {
            Text("Main Book Buddy View")
                .font(.largeTitle)
            
            // Add your main functionality here
        }
        .navigationTitle("Book Buddy")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        Main()
    }
}
