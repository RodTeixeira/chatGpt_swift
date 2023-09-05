//
//  TextMessageTableViewCell.swift
//  ChatGPT_Rodolfo
//
//  Created by Rodolfo on 05/05/23.
//

import UIKit

class TextMessageTableViewCell: UITableViewCell, Identifiable {
    
    private lazy var myMessageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor =  .pink
        view.layer.cornerRadius = 20
        view.layer.maskedCorners =  [.layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
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

extension TextMessageTableViewCell: viewCodeContract {
    func setupHierarchy() {
        addSubview(myMessageView)
        myMessageView.addSubview(mesageLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            myMessageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            myMessageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            myMessageView.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            mesageLabel.leadingAnchor.constraint(equalTo: myMessageView.leadingAnchor, constant: 15),
            mesageLabel.topAnchor.constraint(equalTo: myMessageView.topAnchor, constant: 15),
            mesageLabel.bottomAnchor.constraint(equalTo: myMessageView.bottomAnchor, constant: -15),
            mesageLabel.trailingAnchor.constraint(equalTo: myMessageView.trailingAnchor, constant: -15)
        ])
    }
    
    func setupConfigurations() {
        selectionStyle = .none
        backgroundColor = .backGround
        transform = CGAffineTransform(scaleX: 1, y: -1)
    }
    
}
