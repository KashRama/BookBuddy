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
    
    private var isInputValid: Bool {
        !bookName.isEmpty && !author.isEmpty
    }
    
    var body: some View {
        VStack {
            if (bookName.isEmpty && author.isEmpty) {
                Text("Enter a new book below")
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
            .padding(10)
            
            Button("Enter") {
                pageNumber = "0"
                summary = "Start reading to get a summary!"
                lastDateRead = "Today perhaps?"
            }
            .disabled(!isInputValid)
            .padding(10)
            
            Spacer()
            
            if (!pageNumber.isEmpty && !summary.isEmpty && !lastDateRead.isEmpty) {
                CurrentData(pageNumber: pageNumber, summary: summary, lastReadDate: lastDateRead)
            }
            
            Spacer()
            
            if (!pageNumber.isEmpty && !summary.isEmpty && !lastDateRead.isEmpty) {
                Button("Did you read today? Enter your new info here!") {
                    newDataFlag = true
                }
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
