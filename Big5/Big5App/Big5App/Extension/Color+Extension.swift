//
//  Color+Extension.swift
//  Big5App
//
//  Created by がり on 2021/01/18.
//

import SwiftUI

extension Color {
    static let tPurple = Color(#colorLiteral(red: 0.8807707429, green: 0.7343443036, blue: 0.9914920926, alpha: 1))
    static let tSky = Color(#colorLiteral(red: 0.4479305744, green: 0.7902210355, blue: 0.9117385745, alpha: 1))
    
    static let gradient = LinearGradient(gradient: Gradient(colors: [Color.tPurple, Color.tSky]),
    startPoint: .top,
    endPoint: .bottom)
    
    static let diagonalGradient = LinearGradient(gradient: Gradient(colors: [Color.tPurple, Color.tSky]),
    startPoint: .topLeading,
    endPoint: .bottomTrailing)
    
}
