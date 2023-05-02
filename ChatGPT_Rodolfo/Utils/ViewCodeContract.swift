//
//  ViewCodeContract.swift
//  ChatGPT_Rodolfo
//
//  Created by Rodolfo on 22/04/23.
//

import Foundation

public protocol viewCodeContract {
    func setupHierarchy()
    func setupConstraints()
    func setupConfigurations()
}

public extension viewCodeContract {
    
    func setupView() {
        setupHierarchy()
        setupConstraints()
        setupConfigurations()
    }
    
    func setupConfigurations() {
        //default
    }
    
}
