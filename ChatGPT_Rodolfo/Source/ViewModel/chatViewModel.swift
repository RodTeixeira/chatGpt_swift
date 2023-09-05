//
//  chatViewModel.swift
//  ChatGPT_Rodolfo
//
//  Created by Rodolfo on 18/04/23.
//

import UIKit

protocol chatViewModelProtocol: AnyObject {
    func sucess()
    func error()
    
}

class chatViewModel {
    
    private weak var delegate: chatViewModelProtocol?
    private var messageList: [Message] = []
    public func delegate(delegate: chatViewModelProtocol?) {
        self.delegate = delegate
    }
    
    private var service: ChatService = ChatService()
    
    func fetchService(text: String) {
        service.sendOpenAIRequest(text: text) {  [weak self] result in
            switch result {
            case .success(let success):
                self?.delegate?.sucess()
                self?.addMessage(message: success, type: .chatGPT)
            case .failure(let failure):
                self?.addMessage(message: failure.localizedDescription, type: .chatGPT)
                self?.delegate?.error()
            }
        }
        
    }

    func addMessage(message: String, type: TypeMessage) {
        let msg = message.trimmingCharacters(in: .whitespacesAndNewlines)
        messageList.insert(Message(message: msg, date: Date(), typeMessage: type), at: .zero)
    }
    
    var numberOfRows: Int {
        messageList.count
    }
    
    func loadCurrentMessage(indexPath: IndexPath) -> Message {
        messageList[indexPath.row]
    }
    
    func heightForRow(IndexPath: IndexPath) -> CGFloat{
        let message  = loadCurrentMessage(indexPath: IndexPath).message
        let font  = UIFont.helveticaNeueMedium(size: 16)
        let estimateHight = message.heightWithConstrainedWidth(width: 200, font: font)
        return estimateHight + 65
    }

}
