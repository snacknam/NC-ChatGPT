//
//  Network.swift
//  NC-ChatGPT
//
//  Created by 관식 on 2023/08/23.
//

import Foundation

class OpenAIService {
    private let url = URL(string: "https://api.openai.com/v1/chat/completions")!
    
    func sendMessage(messages: [Message]) async throws -> ChatResponse {
        var request = URLRequest(url: url)
        
        request.addValue("Bearer \(Bundle.main.openAIKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
    
        let chatMessage = messages.map{ChatMessage(role: $0.role, content: $0.content)}
        let requestBody = ChatBody(model: "gpt-3.5-turbo", messages: chatMessage)
        request.httpBody = try JSONEncoder().encode(requestBody)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode >= 200,
              httpResponse.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        
        let decodedData = try JSONDecoder().decode(ChatResponse.self, from: data)
        print(decodedData)
        return decodedData
    }
}

extension Bundle {
    var openAIKey: String {
        guard let file = self.path(forResource: "Secret", ofType: "plist") else { return "" }
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["OpenAIKey"] as? String else {
            fatalError("OpenAIKey error")
        }
        return key
    }
}
