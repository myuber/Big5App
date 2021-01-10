//
//  big5QuesCard.swift
//  Big5
//
//  Created by がり on 2021/01/10.
//  Copyright © 2021 がり. All rights reserved.
//

import SwiftUI


struct big5QuesCard: View {
    var QuestionWord: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.white)                // グラデーションを設定
                .frame(width: CGFloat.cardWidth - 50, height: CGFloat.cardHeight - 290)      // サイズを指定
                
                .shadow(color: Color.black.opacity(0.4), radius: 12.5, x: 0, y: 18)     // 影を描画
                .opacity(0.7)
            
            Text(QuestionWord)
                .frame(width: CGFloat.cardWidth - 90, height: CGFloat.cardHeight - 290)
        } //:ZStack
    }
}

struct big5QuesCard_Previews: PreviewProvider {
    static var previews: some View {
        big5QuesCard(QuestionWord: "質問文")
    }
}

