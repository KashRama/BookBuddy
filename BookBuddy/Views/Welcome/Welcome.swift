//
//  Welcome.swift
//  BookBuddy
//
//  Created by Kashyap Ramachandrula on 4/24/26.
//

import SwiftUI

struct Welcome: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                
                Image(systemName: "book")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                
                Text("Welcome to Book Buddy!")
                    .font(.custom("Lexend-Regular", size: 25))
                    .bold()
                
                Spacer()
                
                NavigationLink(destination: Main()) {
                    Text("Continue to Book Buddy")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
            }
            .padding()
            .font(.custom("Lexend-Regular", size: 17))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGroupedBackground))
        }
    }
}

#Preview {
    Welcome()
}
