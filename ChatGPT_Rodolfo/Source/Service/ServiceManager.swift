//
//  ServiceManager.swift
//  ChatGPT_Rodolfo
//
//  Created by Rodolfo on 18/04/23.
//

import Foundation
import OpenAISwift

class ServiceManager {
    
    var openAIModelType: OpenAIModelType = .gpt3(.davinci)
    var token: OpenAISwift = OpenAISwift(authToken: API.authToken)
    
}
