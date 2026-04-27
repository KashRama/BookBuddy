//
//  Main.swift
//  BookBuddy
//
//  Created by Kashyap Ramachandrula on 4/25/26.
//
import SwiftUI
import SwiftData

struct Main: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var books: [Book]
    
    @State private var currentBook: Book?
    @State private var newDataFlag: Bool = false
    @State private var showLogHistory: Bool = false
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
                if let book = currentBook {
                    Text("Current Book: \(book.title) by \(book.author)")
                        .padding(10)
                    
                    Text("Or, enter a different book you're reading")
                        .padding(10)
                } else {
                    Text("Enter a new book below")
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
                    let newBook = Book(title: tempBook, author: tempAuthor)
                    modelContext.insert(newBook)
                    currentBook = newBook
                    tempBook = ""
                    tempAuthor = ""
                }
                .disabled(!isInputValid)
                .padding(15)
                
                Spacer()
                
                if let book = currentBook {
                    CurrentData(
                        pageNumber: String(book.currentPage),
                        summary: book.lastSummary,
                        lastReadDate: book.logs.last?.dateRead.formatted(date: .abbreviated, time: .shortened) ?? "Not yet"
                    )
                }
                
                Spacer()
            }
            .font(.custom("Lexend-Regular", size: 15))
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showLogHistory) {
            LogListView(currentBook: $currentBook)
        }
        .onAppear {
            // Set current book to the most recently added one if available
            if currentBook == nil, let lastBook = books.last {
                currentBook = lastBook
            }
        }
        
        if !books.isEmpty {
            Button {
                showLogHistory = true
            } label: {
                HStack {
                    Image(systemName: "book.closed")
                    Text("View Reading History")
                }
                .font(.custom("Lexend-Regular", size: 15))
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(8)
            }
        }
        
        if currentBook != nil {
            Button("Did you read today? Enter your new info here!") {
                newDataFlag = true
            }
            .sheet(isPresented: $newDataFlag) {
                if let book = currentBook {
                    NewData(book: book)
                }
            }
            .padding(.bottom, -18)
            .font(.custom("Lexend-Regular", size: 15))
        }
    }
}

#Preview {
    NavigationStack {
        Main()
    }
    .modelContainer(for: [Book.self, ReadingLog.self])
}
