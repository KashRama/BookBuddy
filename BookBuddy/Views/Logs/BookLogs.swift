//
//  BookLogsView.swift
//  BookBuddy
//
//  Created by Kashyap Ramachandrula on 4/26/26.
//

import SwiftUI
import SwiftData

struct BookLogsView: View {
    let book: Book
    
    var sortedLogs: [ReadingLog] {
        book.logs.sorted { $0.dateRead > $1.dateRead }
    }
    
    var body: some View {
        List {
            if sortedLogs.isEmpty {
                VStack(spacing: 20) {
                    Image(systemName: "doc.text")
                        .font(.system(size: 50))
                        .foregroundStyle(.secondary)
                    Text("No logs for this book yet")
                        .font(.custom("Lexend-Regular", size: 16))
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding()
            } else {
                ForEach(sortedLogs) { log in
                    VStack(alignment: .leading, spacing: 12) {
                        // Header: Page and Chapter
                        HStack {
                            Label("Page \(log.pageNumber)", systemImage: "book.pages")
                                .font(.custom("Lexend-Regular", size: 16))
                                .fontWeight(.semibold)
                            
                            if !log.chapter.isEmpty && log.chapter != "No chapter included" {
                                Text("• Chapter \(log.chapter)")
                                    .font(.custom("Lexend-Regular", size: 14))
                                    .foregroundStyle(.secondary)
                            }
                        }
                        
                        // Date
                        HStack {
                            Image(systemName: "calendar")
                                .font(.caption)
                            Text(log.dateRead.formatted(date: .abbreviated, time: .shortened))
                                .font(.custom("Lexend-Regular", size: 13))
                                .foregroundStyle(.secondary)
                        }
                        
                        // User notes
                        if !log.userNotes.isEmpty {
                            Text(log.userNotes)
                                .font(.custom("Lexend-Regular", size: 14))
                                .lineSpacing(4)
                                .padding(.top, 4)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Book.self, ReadingLog.self, configurations: config)
    
    let sampleBook = Book(title: "When You See Me", author: "Lisa Gardner")
    let log1 = ReadingLog(pageNumber: 65, chapter: "5", userNotes: "Flora is investigating a new case", dateRead: Date())
    let log2 = ReadingLog(pageNumber: 120, chapter: "8", userNotes: "Major plot twist revealed", dateRead: Date().addingTimeInterval(-86400))
    
    sampleBook.logs = [log1, log2]
    container.mainContext.insert(sampleBook)
    
    return NavigationStack {
        BookLogsView(book: sampleBook)
    }
    .modelContainer(container)
}
