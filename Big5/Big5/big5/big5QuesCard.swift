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
                .frame(width: CGFloat.cardWidth, height: CGFloat.cardHeight)      // サイズを指定
                
                .shadow(color: Color.black.opacity(0.4), radius: 12.5, x: 0, y: 18)     // 影を描画
                .opacity(0.7)
            VStack{
                Text("直感で質問に答えてください")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.top, 30)
                Spacer()
                Text(QuestionWord)
                Spacer()
            } //:VStack
            .frame(width: CGFloat.cardWidth - 20, height: CGFloat.cardHeight)
        } //:ZStack
    }
} //:view

struct big5QuesCard_Previews: PreviewProvider {
    static var previews: some View {
        big5QuesCard(QuestionWord: "質問文")
    }
}

