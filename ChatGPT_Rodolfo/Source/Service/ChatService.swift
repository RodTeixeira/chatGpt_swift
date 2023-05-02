//
//  ChatService.swift
//  ChatGPT_Rodolfo
//
//  Created by Rodolfo on 18/04/23.
//

import UIKit

enum OpenAIError: Error {
    case missingChoiseText
    case apiError(Error)
}

class ChatService: ServiceManager {
    
    func sendOpenAIRequest(text: String, completion: @escaping (Result<String, OpenAIError>) -> Void) {
        token.sendCompletion(with: text, model: openAIModelType, maxTokens: 4000, completionHandler: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    guard let text = model.choices?.first?.text else {
                        completion(.failure(.missingChoiseText))
                        return
                    }
                    completion(.success(text))
                case .failure(let error):
                    completion(.failure(.apiError(error)))
                }
            }
        })
    }

}
