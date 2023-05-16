//
//  Message.swift
//  ChatGPT_Rodolfo
//
//  Created by Rodolfo on 16/05/23.
//

import Foundation


enum TypeMessage {
    case user
    case chatGPT
}

struct Message {
    var message: String
    var date: Date
    var typeMessage: TypeMessage
}
