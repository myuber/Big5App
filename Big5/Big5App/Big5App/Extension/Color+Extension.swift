//
//  Color+Extension.swift
//  Big5App
//
//  Created by がり on 2021/01/24.
//

import SwiftUI

extension Color {
//MARK: -背景
    static let tPurple = Color(#colorLiteral(red: 0.8807707429, green: 0.7343443036, blue: 0.9914920926, alpha: 1))
    static let tSky = Color(#colorLiteral(red: 0.4479305744, green: 0.7902210355, blue: 0.9117385745, alpha: 1))
    
    static let gradient = LinearGradient(gradient: Gradient(colors: [Color.tPurple, Color.tSky]),
    startPoint: .top,
    endPoint: .bottom)
    
    static let diagonalGradient = LinearGradient(gradient: Gradient(colors: [Color.tPurple, Color.tSky]),
    startPoint: .topLeading,
    endPoint: .bottomTrailing)
    
//MARK: -編集＆削除ボタン
    static let EditGradient = LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.02949391678, green: 0, blue: 0.09008836001, alpha: 1)), Color(#colorLiteral(red: 0.3306467533, green: 0.3163265586, blue: 0.3386619687, alpha: 1))]),
    startPoint: .topLeading,
    endPoint: .bottomTrailing)
    
    static let DeleteGradient = LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0, blue: 0.1778914928, alpha: 1)), Color(#colorLiteral(red: 0.9753884673, green: 0.5420213342, blue: 0.4755597115, alpha: 1))]),
    startPoint: .topLeading,
    endPoint: .bottomTrailing)
    
}
