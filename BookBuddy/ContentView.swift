//
//  ContentView.swift
//  BookBuddy
//
//  Created by Kashyap Ramachandrula on 4/24/26.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("userName") private var userName: String = ""
    @State private var showingNamePrompt = false
    @State private var tempName = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                
                Image(systemName: "book.fill")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                
                if userName.isEmpty {
                    Text("Hello, Reader!")
                        .bold()
                } else {
                    Text("Hello, \(userName)!")
                        .font(.custom("Lexend-Regular", size: 25))
                        .bold()
                }
                
                Button("Set Your Name") {
                    showingNamePrompt = true
                }
                
                Spacer()
                
                NavigationLink(destination: MainView()) {
                    Text("Continue to Book Buddy")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
            }
            .padding()
            .font(.custom("Lexend-Regular", size: 17.0))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGroupedBackground))
            .alert("What's your name?", isPresented: $showingNamePrompt) {
                TextField("Name", text: $tempName)
                Button("Save") {
                    userName = tempName
                }
                Button("Cancel", role: .cancel) {
                    tempName = ""
                }
            }
        }
    }
}

// Your main app view where all functionality will live
struct MainView: View {
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
    ContentView()
}
