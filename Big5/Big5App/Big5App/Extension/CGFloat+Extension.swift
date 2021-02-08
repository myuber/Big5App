//
//  CGFloat+Extension.swift
//  Big5App
//
//  Created by がり on 2021/01/24.
//

import SwiftUI


extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
}

extension CGFloat {

    static let cardWidth = UIScreen.screenWidth - 50
    static let cardHeight = UIScreen.screenHeight - 400
}
