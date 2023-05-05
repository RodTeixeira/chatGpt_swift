//
//  TextMessageTableViewCell.swift
//  ChatGPT_Rodolfo
//
//  Created by Rodolfo on 05/05/23.
//

import UIKit

class TextMessageTableViewCell: UITableViewCell {
    
    static let indentifier: String = String(describing: TextMessageTableViewCell.self)
    
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
}

extension TextMessageTableViewCell: viewCodeContract {
    func setupHierarchy() {
        addSubview(myMessageView)
        myMessageView.addSubview(mesageLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
        
        ])
    }
    
    func setupConfigurations() {
        selectionStyle = .none
        backgroundColor = .backGround
    }
    
    
}
