//
//  ChatViewModel.swift
//  NC-ChatGPT
//
//  Created by 관식 on 2023/08/23.
//

import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    
    func sendMessage() {
        
    }
}

struct Message: Decodable {
    let id: UUID
    let content: String
    let createAt: Date
}