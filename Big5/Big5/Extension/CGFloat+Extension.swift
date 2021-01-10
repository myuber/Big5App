//
//  CGFloat+Extension.swift
//  Big5
//
//  Created by がり on 2021/01/08.
//  Copyright © 2021 がり. All rights reserved.
//

import SwiftUI


extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
}

extension CGFloat {

    static let cardWidth = UIScreen.screenWidth - 50
    static let cardHeight = UIScreen.screenHeight - 290
}
