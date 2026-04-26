//
//  CurrentData.swift
//  BookBuddy
//
//  Created by Kashyap Ramachandrula on 4/25/26.
//
import SwiftUI

struct CurrentData: View {
    let pageNumber: String
    let summary: String
    let lastReadDate: String
    
    private var isSummarySingleLine: Bool {
        summary.count <= 32
    }
 
    var body: some View {
        Text("Where you left off last")
            .padding(.bottom, 20)
            .font(.custom("Lexend-Regular", size: 25))
            .underline()

        Text("Page Number")
            .font(.custom("Lexend-Regular", size: 18))

        Circle()
            .stroke(Color.blue)
            .frame(width: 200, height: 200)
            .overlay(
                VStack {
                    Text(pageNumber)
                        .font(.custom("Lexend-Regular", size: 100))
                }
            )
            .padding(.bottom, 20)
        
        Text("Summary to where you left off")
            .font(.custom("Lexend-Regular", size: 18))
            .padding(.bottom, 10)

        Text(LocalizedStringKey(summary))
            .lineSpacing(6)
            .multilineTextAlignment(isSummarySingleLine ? .center : .leading)
            .frame(maxWidth: .infinity, alignment: isSummarySingleLine ? .center : .leading)
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        
        Text("Last time you read")
            .padding(.bottom, 10)
            .font(.custom("Lexend-Regular", size: 18))

        Text(lastReadDate)
            .padding(.bottom, 20)
    }
}


#Preview {
    NavigationStack {
        CurrentData(
            pageNumber: "65",
            summary: "Start reading to get a summary!",
            lastReadDate: "04-25-2025 at 10:35 PM")
    }
}
