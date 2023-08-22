//
//  Network.swift
//  NC-ChatGPT
//
//  Created by 관식 on 2023/08/23.
//

import Foundation

class OpenAIService {
    let url = "https://api.openai.com/v1/chat/completions"
    func sendMessage() {
        
    }
}

struct ChatBody: Encodable {
    let model: String
    let messages: [ChatMessage]
}

struct ChatMessage: Encodable {
    let role: SenderRole
    let content: String
}

enum SenderRole: String, Encodable {
    case system
    case user
    case assistant
}
