//
//  Book.swift
//  BookBuddy
//
//  Created by Kashyap Ramachandrula on 4/26/26.
//

import SwiftData
import Foundation

@Model
class Book {
    var id: UUID
    var title: String
    var author: String
    var dateAdded: Date
    
    // Relationship: one book has many logs
    @Relationship(deleteRule: .cascade) var logs: [ReadingLog]
    
    // Current reading state
    var currentPage: Int
    var currentChapter: String
    var lastSummary: String
    
    init(title: String, author: String) {
        self.id = UUID()
        self.title = title
        self.author = author
        self.dateAdded = Date()
        self.logs = []
        self.currentPage = 0
        self.currentChapter = ""
        self.lastSummary = "Start reading to get a summary!"
    }
}
