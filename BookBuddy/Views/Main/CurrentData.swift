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
 
    var body: some View {
        Text("Where you left off last")
            .padding(30)
            .font(.custom("Lexend-Regular", size: 25))
            .underline()

        Text("Page Number")
            .font(.custom("Lexend-Regular", size: 18))

        Circle()
            .fill(Color.blue)
            .frame(width: 200, height: 200)
            .overlay(
                VStack {
                    Text("\(pageNumber)")
                        .font(.custom("Lexend-Regular", size: 100))
                }
            )
            .padding(.bottom, 30)
        
        Text("Summary to where you left off")
            .padding(.bottom, 10)
            .font(.custom("Lexend-Regular", size: 18))

        Text("\(summary)")
            .lineSpacing(6)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 30)
        
        Text("Last time you read")
            .padding(.bottom, 10)
            .font(.custom("Lexend-Regular", size: 18))

        Text("\(lastReadDate)")
            .padding(.bottom, 30)
    }
}


#Preview {
    NavigationStack {
        CurrentData(
            pageNumber: "65",
            summary: "The first chapter reintroduces Flora Dane as she reflects on her survival instincts and hyper-vigilant mindset following her past trauma, setting a tense and uneasy tone for the investigation ahead.",
            lastReadDate: "04-25-2025 at 10:35 PM")
    }
}
