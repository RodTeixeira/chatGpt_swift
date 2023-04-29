//
//  ViewController.swift
//  CHATGPT
//
//

import UIKit
import OpenAISwift

enum OpenAIError: Error {
    case missingChoiseText
    case apiError(Error)
}

class ChatViewController: UIViewController {
    
    private var VM = chatViewModel()
    var screen: ChatView?
    
    override func loadView() {
        self.screen = ChatView()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
//        VM.fetchService(text: "que dia é hoje")
    }
    
    private func setup() {
        VM.delegate(delegate: self)
    }

}

extension ChatViewController: chatViewModelProtocol {
    func sucess(response: String) {
        print(response)
    }
    
    func error(msgError: String) {
        print(msgError)
    }
    
}

extension ChatViewController:  viewCodeContract {
    func setupHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func setupConfigurations() {
        guard let logo = UIImage(named: "logo") else { return }
        self.addLogoToNavigationBarItem(image: logo)
        setup()
        hideKeyboardWhenTappedAround()
    }
}
