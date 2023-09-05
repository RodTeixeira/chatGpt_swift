//
//  UITableView+Extension.swift
//  ChatGPT_Rodolfo
//
//  Created by Rodolfo on 04/09/23.
//

import Foundation
import UIKit

extension Identifiable where Self: UIView {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

extension UITableView {
    
    func register<T: UIView>(cellType: T.Type) where T: Identifiable {
        self.register(cellType.self, forCellReuseIdentifier: cellType.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(cellType: T.Type, for indexPath: IndexPath) -> T where T: Identifiable {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as? T else {
            fatalError("Unablec to dequeue with identifier: \(cellType.identifier)")
        }
        return cell
    }
    
    func isLastCell(in indexPath: IndexPath) -> Bool {
        let lastRowsIndex: Int = numberOfRows(inSection: indexPath.section) - 1
        return indexPath.row == lastRowsIndex
    }
    
    private func reloadRows(section: Int = 0) {
        for cellIndex in 0..<numberOfRows(inSection: section) {
            reloadRows(at: [.init(row: cellIndex, section: section)], with: .none)
        }
    }
    
    func reloadVisibleRows(section: Int = 0, performWithoutAnimation: Bool = false) {
        guard !performWithoutAnimation else {
            reloadRows(section: section)
            return
        }
        
        UIView.performWithoutAnimation {
            reloadRows(section: section)
        }
    }
    
}
