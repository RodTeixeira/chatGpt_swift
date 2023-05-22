//
//  ViewController.swift
//  CHATGPT
//
//

import UIKit

class ChatViewController: UIViewController {
    
    private var viewModel = chatViewModel()
    var screen: ChatView?
    
    override func loadView() {
        self.screen = ChatView()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let logo = UIImage(named: "logo") else { return }
        self.addLogoToNavigationBarItem(image: logo)
    }
    
    private func setup() {
        viewModel.delegate(delegate: self)
    }
    
    private func vibrate() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
    
    private func reloadTableView() {
        vibrate()
        screen?.reloadTableview()
    }
    
    
}

extension ChatViewController: chatViewModelProtocol {
    func sucess() {
        reloadTableView()
    }
    
    func error() {
        reloadTableView()
    }
    
}

extension ChatViewController:  viewCodeContract {
    func setupHierarchy() {
        //empty
    }
    
    func setupConstraints() {
        //empty
    }
    
    func setupConfigurations() {
        setup()
        hideKeyboardWhenTappedAround()
        screen?.delegate(delegate: self)
        screen?.configTableView(delegate: self, dataSorce: self)
    }
}

extension ChatViewController: chatViewDelegate {
    
    func sendMsg(text: String) {
        viewModel.addMessage(message: text, type: .user)
        reloadTableView()
        viewModel.fetchService(text: text)
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message  = viewModel.loadCurrentMessage(indexPath: indexPath)
        
        switch message.typeMessage {
        case .user:
            let indentifier = TextMessageTableViewCell.indentifier
            let cell = tableView.dequeueReusableCell(withIdentifier: indentifier, for: indexPath) as? TextMessageTableViewCell
            cell?.setupCell(text: message)
            return cell ?? UITableViewCell()
            
        case .chatGPT:
            let indentifier = IncomingTextMessageTableViewCell.indentifier
            let cell = tableView.dequeueReusableCell(withIdentifier: indentifier, for: indexPath) as? IncomingTextMessageTableViewCell
            cell?.setupCell(text: message)
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRow(IndexPath: indexPath)
    }
    
}

