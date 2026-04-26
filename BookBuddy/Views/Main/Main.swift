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
    @AppStorage("chapter") private var chapter = ""
    @AppStorage("summary") private var summary = ""
    @AppStorage("userSummary") private var userSummary = ""
    @AppStorage("lastDateRead") private var lastDateRead = ""
    
    @State private var newDataFlag: Bool = false
    
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
            
            CurrentData(pageNumber: "65", summary: "", lastReadDate: "04-24-2026")
            
            Spacer()
            
            Button("Did you read today? Enter your new info here!") {
                newDataFlag = true
            }
        }
        .font(.custom("Lexend-Regular", size: 15))
        .sheet(isPresented: $newDataFlag) {
            NewData(
                pageNumber: $pageNumber,
                chapter: $chapter,
                userSummary: $userSummary
            )
        }
    }
}

#Preview {
    NavigationStack {
        Main()
    }
}
