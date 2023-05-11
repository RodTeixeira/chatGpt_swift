//
//  ViewController.swift
//  CHATGPT
//
//

import UIKit

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
        screen?.delegate(delegate: self)
        screen?.configTableView(delegate: self, dataSorce: self)
    }
}

extension ChatViewController: chatViewDelegate {
    
    func sendMsg(text: String) {
        debugPrint(text)
    }
    
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }
    
}

