//
//  ContentView.swift
//  NC-ChatGPT
//
//  Created by 관식 on 2023/08/23.
//

import SwiftUI

struct ChatView: View {
    
    @StateObject var viewModel = ChatViewModel()
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            VStack {
                Spacer()
                if viewModel.messages.isEmpty {
                    VStack(spacing: 4) {
                        Text("Ask Anything!")
                            .font(.system(size: 20, weight: .semibold))
                        Text("The ChatGPT will answer your question!")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                } else {
                    ScrollView {
                        VStack {
                            ForEach(viewModel.messages.filter({$0.role != .system}), id: \.id) { message in
                                messageView(message: message)
                            }
                            if viewModel.isLoading {
                                HStack {
                                    ProgressView()
                                        .padding(.vertical, 4)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                Spacer()
                HStack {
                    TextField("text here...", text: $viewModel.currentInput)
                        .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(.white)
                                .frame(height: 48)
                        )
                    Button {
                        viewModel.sendMessage()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(.black)
                                .frame(width: 80, height: 48)
                            Text("Send")
                                .foregroundColor(.white)
                        }
                    }
                    
                }
            }
            .padding()
        }
        .tint(Color.black)
    }
    
    func messageView(message: Message) -> some View {
        HStack(alignment: .top) {
            if message.role == .user {
                Spacer()
                Text(message.content)
                    .padding(12)
                    .background(
                        message.role == .user ? Color.white : Color.white
                    )
                    .cornerRadius(8)
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.top, 4)
            }
            if message.role == .assistant {
                Image(systemName: "paperplane.circle.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.top, 4)
                Text(message.content)
                    .padding(12)
                    .background(
                        message.role == .user ? Color.white : Color.white
                    )
                    .cornerRadius(8)
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
