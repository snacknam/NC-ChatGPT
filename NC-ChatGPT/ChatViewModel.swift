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
    
    func sendMessage() {
        
    }
}
