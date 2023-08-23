//
//  ChatViewModel.swift
//  NC-ChatGPT
//
//  Created by 관식 on 2023/08/23.
//

import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var currentInput: String = ""
    @Published var isLoading: Bool = false
    
    private let openAIService = OpenAIService()
    
    func sendMessage() {
        let newMessage = Message(id: UUID(), role: .user, content: currentInput, createAt: Date())
        messages.append(newMessage)
        currentInput = ""
        isLoading = true
        
        Task {
            let response = try await openAIService.requestMessage(messages: messages)
            guard let receivedResponse = response.choices.first?.message else {
                print("Had no received message")
                return
            }
            let receivedMessage = Message(id: UUID(), role: receivedResponse.role, content: receivedResponse.content, createAt: Date())
            await MainActor.run(body: {
                messages.append(receivedMessage)
            })
            isLoading = false
        }
    }
}
