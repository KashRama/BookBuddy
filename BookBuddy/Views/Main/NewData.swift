//
//  NewData.swift
//  BookBuddy
//
//  Created by Kashyap Ramachandrula on 4/25/26.
//
import SwiftUI

struct NewData: View {
    @Binding var pageNumber: String
    @Binding var chapter: String
    @Binding var userSummary: String
    @Binding var lastDateRead: String
    
    @Environment(\.dismiss) private var dismiss
    
    private var isFormValid: Bool {
        !pageNumber.isEmpty && !userSummary.isEmpty
    }
    
    var body: some View {
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
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 1)
                )

            Spacer()
            
            Button("Submit!") {
                let formatter = DateFormatter()
                formatter.dateFormat = "MM-dd-yyyy 'at' hh:mm a"
                lastDateRead = formatter.string(from: Date.now)  // ← Fixed!
                
                dismiss()
            }
            .font(.custom("Lexend-Regular", size: 20))
            .disabled(!isFormValid)
            
        }
        .font(.custom("Lexend-Regular", size: 15))
        .padding(20)

    }
    
}

#Preview {
    NavigationStack {
        NewData(
            pageNumber: .constant("65"),
            chapter: .constant("5"),
            userSummary: .constant("Just read 100 pages of the book"),
            lastDateRead: .constant("2021-09-01")
        )
    }
}
