//
//  NewData.swift
//  BookBuddy
//
//  Created by Kashyap Ramachandrula on 4/25/26.
//
import SwiftUI
import SwiftData

struct NewData: View {
    let book: Book
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var pageNumber = ""
    @State private var chapter = ""
    @State private var userSummary = ""
    @State private var isLoadingAI = false
    @State private var errorMessage: String?
    @FocusState private var focusedField: Field?
    
    enum Field {
        case pageNumber
        case chapter
        case summary
    }
    
    private var isFormValid: Bool {
        !pageNumber.isEmpty && !userSummary.isEmpty
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Enter today's information:")
                    .font(.custom("Lexend-Regular", size: 25))
                    .padding(.bottom, 40)
                
                Text("What page did you leave off?")
                    .padding(.top, 30)
                    .padding(.bottom, 15)
                
                TextField("", text: $pageNumber)
                    .padding(.vertical, 10)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .frame(width: 90)
                    .focused($focusedField, equals: .pageNumber)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1)
                    )
                
                Text("What was the last chapter you finished?")
                    .padding(.top, 30)
                    .padding(.bottom, 15)
                
                TextField("", text: $chapter)
                    .padding(.vertical, 10)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .frame(width: 120)
                    .focused($focusedField, equals: .chapter)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1)
                    )
                
                Text("Give a quick summary of the last thing that happened:")
                    .padding(.top, 30)
                    .padding(.bottom, 15)

                TextEditor(text: $userSummary)
                    .frame(height: 150)
                    .padding(.vertical, 10)
                    .focused($focusedField, equals: .summary)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1)
                    )

                Spacer()
                
                if let error = errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                        .font(.caption)
                }
                
                Button("Submit!") {
                    focusedField = nil
                    Task {
                        await submitReading()
                    }
                }
                .font(.custom("Lexend-Regular", size: 20))
                .disabled(!isFormValid || isLoadingAI)
                
                if isLoadingAI {
                    ProgressView("Generating summary...")
                        .padding(.top)
                }
            }
            .font(.custom("Lexend-Regular", size: 15))
            .padding(20)
            .padding(.bottom, 100)
        }
        .onTapGesture {
            focusedField = nil
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    focusedField = nil
                }
            }
        }
        .onAppear {
            // Pre-fill with current values
            pageNumber = String(book.currentPage)
            chapter = book.currentChapter
        }
    }
    
    private func submitReading() async {
        isLoadingAI = true
        errorMessage = nil
        
        do {
            // Generate AI summary
            let aiSummary = try await ClaudeAPIService.shared.generateSummary(
                userInput: userSummary,
                bookTitle: book.title,
                author: book.author,
                pageNumber: pageNumber,
                chapter: chapter.isEmpty ? "No chapter included" : chapter
            )
            
            // Create new reading log
            let newLog = ReadingLog(
                pageNumber: Int(pageNumber) ?? 0,
                chapter: chapter.isEmpty ? "No chapter included" : chapter,
                userNotes: userSummary,
                dateRead: Date()
            )
            
            // Update book's current state
            book.currentPage = Int(pageNumber) ?? 0
            book.currentChapter = chapter
            book.lastSummary = aiSummary
            book.logs.append(newLog)
            
            // SwiftData automatically saves
            
            isLoadingAI = false
            dismiss()
            
        } catch {
            isLoadingAI = false
            errorMessage = "Failed to generate summary: \(error.localizedDescription). Try again later"
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Book.self, ReadingLog.self, configurations: config)
    
    let sampleBook = Book(title: "When You See Me", author: "Lisa Gardner")
    container.mainContext.insert(sampleBook)
    
    return NavigationStack {
        NewData(book: sampleBook)
    }
    .modelContainer(container)
}
