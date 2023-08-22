//
//  ChatModel.swift
//  NC-ChatGPT
//
//  Created by 관식 on 2023/08/23.
//

import Foundation

// MARK: - Message
struct Message: Decodable {
    let id: UUID
    let role: SenderRole
    let content: String
    let createAt: Date
}

// MARK: - Request
struct ChatBody: Encodable {
    let model: String
    let messages: [ChatMessage]
}

struct ChatMessage: Codable {
    let role: SenderRole
    let content: String
}

enum SenderRole: String, Codable {
    case system
    case user
    case assistant
}

// MARK: - Response
struct ChatResponse: Decodable {
    let choices: [ChatChoice]
}

struct ChatChoice: Decodable {
    let message: ChatMessage
}
