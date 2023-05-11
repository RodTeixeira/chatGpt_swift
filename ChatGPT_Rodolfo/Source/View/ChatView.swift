//
//  ChatView.swift
//  ChatGPT_Rodolfo
//
//  Created by Rodolfo on 19/04/23.
//

import UIKit
import AVFoundation


protocol chatViewDelegate: AnyObject {
    func sendMsg(text: String)
}

class ChatView: UIView {
    
    private var player: AVAudioPlayer?
    private weak var delegate: chatViewDelegate?
    
    private lazy var messageInputView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .backGround
        return view
    }()
    
    private lazy var messageBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .appLight
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var sendButton: UIButton = {
        let but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.backgroundColor = .pink
        but.layer.cornerRadius = 22
        but.clipsToBounds = true
        but.layer.shadowRadius = 10
        but.layer.shadowOffset = CGSize(width: 0, height: 5)
        but.layer.shadowOpacity = 0.3
        but.isEnabled = false
//        but.transform = .init(scaleX: 0.8, y: 0.8)
        but.setImage(UIImage(named: "send"), for: .normal)
        but.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return but
    }()
    
    private lazy var textField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Digite aqui"
        field.font = UIFont.helveticaNeueMedium(size: 16)
        field.textColor = .darkGray
        field.autocorrectionType = .no
        field.keyboardType = .asciiCapable
        field.delegate = self
        return field
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(TextMessageTableViewCell.self, forCellReuseIdentifier: TextMessageTableViewCell.indentifier)
        table.register(IncomingTextMessageTableViewCell.self, forCellReuseIdentifier: IncomingTextMessageTableViewCell.indentifier)
        table.separatorColor = .none
        table.backgroundColor = .clear
        table.transform  = CGAffineTransform(scaleX: 1, y: -1)
        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configTableView(delegate: UITableViewDelegate, dataSorce: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSorce
    }
    
    func delegate(delegate: chatViewDelegate?) {
        self.delegate = delegate
    }
    
    //MARK: Private metodos
    @objc
    private func tapButton() {
        delegate?.sendMsg(text: textField.text ?? .empty)
        sendButton.touchAnimation()
        playSound()
        pushMsg()
    }
    
    private func pushMsg() {
        textField.text = .empty
        sendButton.isEnabled = false
        sendButton.transform = .init(scaleX: 0.8, y: 0.8)
    }
    
    private func playSound() {
        guard let url = Bundle.main.url(forResource: "send", withExtension: "wav") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            guard let player = self.player else { return }
            player.play()
        } catch let error {
            debugPrint("erro \(error.localizedDescription)")
        }
    }
    
}

extension ChatView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text  as NSString? else { return false }
        let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
        
        if txtAfterUpdate.isEmpty {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.sendButton.isEnabled = false
                self.sendButton.transform = .init(scaleX: 0.8, y: 0.8)
                
            })
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.sendButton.isEnabled = true
                self.sendButton.transform = .identity
            })
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}


extension ChatView: viewCodeContract {
    
    func setupHierarchy() {
        addSubview(tableView)
        addSubview(messageInputView)
        addSubview(sendButton)
        messageInputView.addSubview(messageBarView)
        messageInputView.addSubview(textField)
    }
    
    func  setupConstraints() {
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: messageInputView.topAnchor),
            
            messageInputView.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor),
            messageInputView.leadingAnchor.constraint(equalTo: leadingAnchor),
            messageInputView.trailingAnchor.constraint(equalTo: trailingAnchor),
            messageInputView.heightAnchor.constraint(equalToConstant: 80),
            
            messageBarView.leadingAnchor.constraint(equalTo: messageInputView.leadingAnchor, constant: 20),
            messageBarView.trailingAnchor.constraint(equalTo: messageInputView.trailingAnchor, constant: -20),
            messageBarView.heightAnchor.constraint(equalToConstant: 55),
            messageBarView.centerYAnchor.constraint(equalTo: messageInputView.centerYAnchor),
            
            sendButton.trailingAnchor.constraint(equalTo: messageBarView.trailingAnchor, constant: -15),
            sendButton.heightAnchor.constraint(equalToConstant: 55),
            sendButton.widthAnchor.constraint(equalToConstant: 55),
            sendButton.bottomAnchor.constraint(equalTo: messageBarView.bottomAnchor, constant: -10),
            
            textField.leadingAnchor.constraint(equalTo: messageBarView.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: sendButton.trailingAnchor, constant: -5),
            textField.heightAnchor.constraint(equalToConstant: 45),
            textField.centerYAnchor.constraint(equalTo: messageBarView.centerYAnchor)
            
            
        ])
    }
    
    func setupConfigurations() {
        backgroundColor = .backGround
        
    }
    
}
