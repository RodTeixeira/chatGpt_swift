//
//  IncomingTextMessageTableViewCell.swift
//  ChatGPT_Rodolfo
//
//  Created by Rodolfo on 08/05/23.
//

import UIKit

class IncomingTextMessageTableViewCell: UITableViewCell {

    static let indentifier: String = String(describing: IncomingTextMessageTableViewCell.self)
    
    private lazy var contactMessageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor =  .incomingColor
        view.layer.cornerRadius = 20
        view.layer.maskedCorners =  [.layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private lazy var mesageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.helveticaNeueMedium(size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupCell(text: Message) {
        mesageLabel.text = text.message
    }
}

extension IncomingTextMessageTableViewCell: viewCodeContract {
    func setupHierarchy() {
        addSubview(contactMessageView)
        contactMessageView.addSubview(mesageLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contactMessageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            contactMessageView.leadingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            contactMessageView.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            mesageLabel.leadingAnchor.constraint(equalTo: contactMessageView.leadingAnchor, constant: 15),
            mesageLabel.topAnchor.constraint(equalTo: contactMessageView.topAnchor, constant: 15),
            mesageLabel.bottomAnchor.constraint(equalTo: contactMessageView.bottomAnchor, constant: -15),
            mesageLabel.trailingAnchor.constraint(equalTo: contactMessageView.trailingAnchor, constant: -15)
        ])
    }
    
    func setupConfigurations() {
        selectionStyle = .none
        backgroundColor = .backGround
        transform = CGAffineTransform(scaleX: 1, y: -1)
    }
    
}
