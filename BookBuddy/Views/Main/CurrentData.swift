//
//  CurrentData.swift
//  BookBuddy
//
//  Created by Kashyap Ramachandrula on 4/25/26.
//
import SwiftUI

struct CurrentData: View {
    let book: String
    let author: String
    let pageNumber: String
    let summary: String
    let lastReadDate: String
    
    private var isSummarySingleLine: Bool {
        summary.count <= 32
    }
 
    var body: some View {
        Text(book)
            .font(.custom("Lexend-Regular", size: 25))

        Text(author)
            .padding(.bottom, 20)
        
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
            book: "When You See Me",
            author: "Lisa Gardner",
            pageNumber: "65",
            summary: "Start reading to get a summary!",
            lastReadDate: "04-25-2025 at 10:35 PM")
    }
}
