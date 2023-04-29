//
//  chatViewModel.swift
//  ChatGPT_Rodolfo
//
//  Created by Rodolfo on 18/04/23.
//

import UIKit

protocol chatViewModelProtocol: AnyObject {
    func sucess(response: String)
    func error(msgError: String)
    
}

class chatViewModel {
    
    private weak var delegate: chatViewModelProtocol?
    
    public func delegate(delegate: chatViewModelProtocol?) {
        self.delegate = delegate
    }
    
    private var service: ChatService = ChatService()
    
    func fetchService(text: String) {
        service.sendOpenAIRequest(text: text) {  [weak self] result in
            switch result {
            case .success(let success):
                self?.delegate?.sucess(response: success)
            case .failure(let failure):
                self?.delegate?.error(msgError: failure.localizedDescription)
            }
        }
        
    }

}
