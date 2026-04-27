//
//  ReadingLog.swift
//  BookBuddy
//
//  Created by Kashyap Ramachandrula on 4/26/26.
//

import SwiftData
import Foundation

@Model
class ReadingLog {
    var id: UUID
    var pageNumber: Int
    var chapter: String
    var userNotes: String
    var dateRead: Date
    
    // Relationship: many logs belong to one book
    var book: Book?
    
    init(pageNumber: Int, chapter: String, userNotes: String, dateRead: Date = Date()) {
        self.id = UUID()
        self.pageNumber = pageNumber
        self.chapter = chapter
        self.userNotes = userNotes
        self.dateRead = dateRead
    }
}
