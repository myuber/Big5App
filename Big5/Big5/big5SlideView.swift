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
    
    @EnvironmentObject var ObservedClass: ObservedClass
    
// MARK: - Body
    var body: some View {
        VStack {
            ZStack {
                
                Color.gradient.edgesIgnoringSafeArea(.all)
//MARK: - Card
                HStack(spacing: 50) {
                    
                    ForEach (0..<10) { num in
                        ZStack {
                            RoundedRectangle(cornerRadius: 40)
                                .fill(Color.white)                // グラデーションを設定
                                .frame(width: CGFloat.cardWidth - 50, height: CGFloat.cardHeight - 290)      // サイズを指定
                                
                                .shadow(color: Color.black.opacity(0.4), radius: 12.5, x: 0, y: 18)     // 影を描画
                                .opacity(0.7)
                            
                            Text(self.ObservedClass.quesList[num])
                        } //:ZStack
                    } //:ForEach
                    
                } //:HStack
                    .offset(x: CGFloat.cardWidth * 4.5)
                    .offset(x: -CGFloat.cardWidth * CGFloat(showSlideNum))       // 移動
                .animation(showSlideMenu ? Animation.spring().delay(0.1) : Animation.spring().delay(0.5))   //アニメーションを指定（delay/trueのときは早め、falseのときはちょっと遅れて始まる）
            } //:ZStack
            
//MARK: - Button
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
            
        } //:VStack
        
    } //:body
} //:view

struct big5SlideView_Previews: PreviewProvider {
    static var previews: some View {
        big5SlideView()
    }
}
