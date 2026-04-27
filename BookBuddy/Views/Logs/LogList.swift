//
//  LogListView.swift
//  BookBuddy
//
//  Created by Kashyap Ramachandrula on 4/26/26.
//

import SwiftUI
import SwiftData

struct LogListView: View {
    @Query(sort: \Book.dateAdded, order: .reverse) private var books: [Book]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            if books.isEmpty {
                VStack(spacing: 20) {
                    Image(systemName: "book.closed")
                        .font(.system(size: 60))
                        .foregroundStyle(.secondary)
                    Text("No reading history yet")
                        .font(.custom("Lexend-Regular", size: 20))
                        .foregroundStyle(.secondary)
                    Text("Start logging your reading sessions to see them here!")
                        .font(.custom("Lexend-Regular", size: 14))
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding()
            } else {
                List(books) { book in
                    NavigationLink(destination: BookLogsView(book: book)) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(book.title)
                                .font(.custom("Lexend-Regular", size: 18))
                                .fontWeight(.semibold)
                            
                            Text(book.author)
                                .font(.custom("Lexend-Regular", size: 14))
                                .foregroundStyle(.secondary)
                            
                            HStack {
                                Image(systemName: "book.pages")
                                    .font(.caption)
                                Text("\(book.logs.count) reading sessions")
                                    .font(.custom("Lexend-Regular", size: 12))
                                
                                Spacer()
                                
                                if let lastLog = book.logs.sorted(by: { $0.dateRead > $1.dateRead }).first {
                                    Text(lastLog.dateRead.formatted(date: .abbreviated, time: .omitted))
                                        .font(.custom("Lexend-Regular", size: 12))
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle("Reading History")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        LogListView()
    }
    .modelContainer(for: [Book.self, ReadingLog.self])
}
