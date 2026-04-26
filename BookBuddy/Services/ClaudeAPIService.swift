//
//  ClaudeAPIService.swift
//  BookBuddy
//
//  Created by Kashyap Ramachandrula on 4/26/26.
//

import Foundation

enum ClaudeAPIError: Error {
    case invalidURL
    case invalidResponse
    case apiError(String)
}

class ClaudeAPIService {
    static let shared = ClaudeAPIService()
    private let apiKey = Secrets.claudeAPIKey
    private let systemPrompt = Secrets.systemPrompt
    private let baseURL = "https://api.anthropic.com/v1/messages"
    
    private init() {}
    
    func generateSummary(userInput: String, bookTitle: String, author: String, pageNumber: String, chapter: String = "No chapter included") async throws -> String {
        guard let url = URL(string: baseURL) else {
            throw ClaudeAPIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.setValue("2023-06-01", forHTTPHeaderField: "anthropic-version")
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        let prompt = """
        I'm reading "\(bookTitle)" by \(author). 
        Here's what happened in my last reading session: \(userInput)
        I left off on page: \(pageNumber)
        This is the last chapter I finished: \(chapter)
        
        Please provide a concise, memorable summary (3-4 sentences) of what has happened up until this point.
        """
        
        let requestBody: [String: Any] = [
            "model": "claude-sonnet-4-6",
            "max_tokens": 1024,
            "system": systemPrompt,
            "messages": [
                [
                    "role": "user",
                    "content": prompt
                ]
            ]
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw ClaudeAPIError.invalidResponse
        }
        
        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
              let content = json["content"] as? [[String: Any]],
              let firstContent = content.first,
              let text = firstContent["text"] as? String else {
            throw ClaudeAPIError.apiError("Invalid response format")
        }
        
        return text
    }
}
