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
    @State private var tempBook = ""
    @State private var tempAuthor = ""
    
    private var isInputValid: Bool {
        !tempBook.isEmpty && !tempAuthor.isEmpty
    }
    
    var body: some View {
//        Debugging button for dev. Uncomment when storage needs to be reset
//        Button("RESET STORAGE") {
//            UserDefaults.standard.removeObject(forKey: "bookName")
//            UserDefaults.standard.removeObject(forKey: "author")
//            UserDefaults.standard.removeObject(forKey: "pageNumber")
//            UserDefaults.standard.removeObject(forKey: "chapter")
//            UserDefaults.standard.removeObject(forKey: "summary")
//            UserDefaults.standard.removeObject(forKey: "userSummary")
//            UserDefaults.standard.removeObject(forKey: "lastDateRead")
//        }
//        .padding(.top, 20)
        ScrollView {
            VStack {
                if bookName.isEmpty && author.isEmpty {
                    Text("Enter a new book below")
                        .padding(10)
                }
                else {
                    Text("Current Book: \(bookName) by \(author)")
                        .padding(10)
                    
                    Text("Or, enter a different book you're reading")
                        .padding(10)
                }
                
                HStack {
                    TextField("Book Name", text: $tempBook)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(.roundedBorder)
                    TextField("Author", text: $tempAuthor)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(10)
                
                Button("Start Reading!") {
                    pageNumber = "1"
                    chapter = "1"
                    summary = "Start reading to get a summary!"
                    userSummary = ""
                    lastDateRead = "Today perhaps?"
                    bookName = tempBook
                    tempBook = ""
                    author = tempAuthor
                    tempAuthor = ""
                }
                .disabled(!isInputValid)
                .padding(15)
                
                Spacer()
                
                if !pageNumber.isEmpty && !summary.isEmpty && !lastDateRead.isEmpty {
                    CurrentData(pageNumber: pageNumber, summary: summary, lastReadDate: lastDateRead)
                }
                
                Spacer()
                
            }
            .font(.custom("Lexend-Regular", size: 15))
            .sheet(isPresented: $newDataFlag) {
                NewData(
                    pageNumber: $pageNumber,
                    chapter: $chapter,
                    userSummary: $userSummary,
                    lastDateRead: $lastDateRead
                )
            }
        }
        .navigationBarHidden(true)
        
        if !pageNumber.isEmpty && !summary.isEmpty && !lastDateRead.isEmpty {
            Button("Did you read today? Enter your new info here!") {
                userSummary = ""
                newDataFlag = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        Main()
    }
}
