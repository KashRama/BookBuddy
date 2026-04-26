//
//  Main.swift
//  BookBuddy
//
//  Created by Kashyap Ramachandrula on 4/25/26.
//
import SwiftUI

struct Main: View {
    @AppStorage("bookName") private var bookName = ""
    @AppStorage("author") private var author = ""
    @AppStorage("pageNumber") private var pageNumber = ""
    @AppStorage("summary") private var summary = ""
    @AppStorage("lastDateRead") private var lastDateRead = ""

    
    var body: some View {
        VStack {
            if (bookName.isEmpty && author.isEmpty) {
                Text("Enter a new book below.")
                    .padding(10)
            }
            else {
                Text("Reading: \(bookName) by \(author)")
                    .padding(10)
            }
            HStack {
                TextField("Book Name", text: $bookName)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
                TextField("Author", text: $author)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
            }
            
            Spacer()
            
            Text("Where you left off last")
                .padding(30)
                .font(.custom("Lexend-Regular", size: 25))

            Text("Page Number")
                .font(.custom("Lexend-Regular", size: 18))

            Circle()
                .fill(Color.blue)
                .frame(width: 200, height: 200)
                .overlay(
                    VStack {
                        Text("65")
                            .font(.custom("Lexend-Regular", size: 100))
                    }
                )
                .padding(.bottom, 30)
            
            Text("Summary to where you left off")
                .padding(.bottom, 10)
                .font(.custom("Lexend-Regular", size: 18))

            Text("The first chapter reintroduces Flora Dane as she reflects on her survival instincts and hyper-vigilant mindset following her past trauma, setting a tense and uneasy tone for the investigation ahead.")
                .lineSpacing(6)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 15)
            
            Text("Last time you read")
                .padding(.bottom, 10)
                .font(.custom("Lexend-Regular", size: 18))

                
            Spacer()
            
        }
        .font(.custom("Lexend-Regular", size: 15))
    }
}

#Preview {
    NavigationStack {
        Main()
    }
}
