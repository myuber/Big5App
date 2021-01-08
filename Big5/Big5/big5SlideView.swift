//
//  big5SlideView.swift
//  
//
//  Created by がり on 2021/01/08.
//

import SwiftUI

struct big5SlideView: View {
    
    //@Binding var showSlideMenu: Bool
    @State var showSlideMenu: Bool = false
    @State var showSlideNum: Int = 0
    
    // MARK: - Body
    var body: some View {
        VStack {
            ZStack {
                HStack(spacing: 50) {
                    ForEach (1..<11) {_ in
                        RoundedRectangle(cornerRadius: 40)
                            .fill(Color.gradient)                // グラデーションを設定
                            .frame(width: CGFloat.cardWidth - 50, height: CGFloat.cardHeight - 290)      // サイズを指定
                            
                            .shadow(color: Color.black.opacity(0.4), radius: 12.5, x: 0, y: 18)     // 影を描画
                            
                    }
                    
                }
                    .offset(x: CGFloat.cardWidth * 4.5)
                    .offset(x: -CGFloat.cardWidth * CGFloat(showSlideNum))       // 移動
                .animation(showSlideMenu ? Animation.spring().delay(0.1) : Animation.spring().delay(0.5))   //アニメーションを指定（delay/trueのときは早め、falseのときはちょっと遅れて始まる）
            }
            
             HStack{
               // ボタンの表示
               ForEach (0..<5) { num in
                   Button(action: {
                       self.showSlideNum = num
                   }, label: {
                       Text(String(num))
                           .foregroundColor(Color.white)
                   }) //:button
                   .frame(width: 50, height: 50)
                   .background(Color.diagonalGradient)
                   .cornerRadius(10)
                   .shadow(radius: 3)
               } //:ForEach
            } //:HStack
        }
    } //:body
}

struct big5SlideView_Previews: PreviewProvider {
    static var previews: some View {
        big5SlideView()
    }
}
