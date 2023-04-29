//
//  UIFont+Extension.swift
//  ChatGPT_Rodolfo
//
//  Created by Rodolfo on 19/04/23.
//

import Foundation
import UIKit

extension UIFont {
    static func helveticaNeueMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
