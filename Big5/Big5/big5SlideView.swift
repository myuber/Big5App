//
//  big5SlideView.swift
//  
//
//  Created by がり on 2021/01/08.
//

import SwiftUI

struct big5SlideView: View {
    //@ObservedObject var personalData: PersonalInfoEntity
    // 保存処理に必要なコンテキスト
    //@Environment(\.managedObjectContext) var viewContext
    
    //@Binding var showSlideMenu: Bool
    @State var showSlideMenu: Bool = false
    @State var showSlideNum: Int = 0
    
    @State var selectQ = ""
    @EnvironmentObject var observedClass: ObservedClass
    
// MARK: - Body
    var body: some View {
        VStack {
            ZStack {
                
                Color.gradient.edgesIgnoringSafeArea(.all)
//MARK: - Card
                HStack(spacing: 50) {
                    
                    // ObservedClassのenumを全て取得して、big5QuesCardで表示
                    ForEach(ObservedClass.big5Category.allCases, id: \.self) { (category) in
                        big5QuesCard(QuestionWord: category.Big5Question())
                    }
                    
                } //:HStack
                    .offset(x: CGFloat.cardWidth * 4.5)
                    .offset(x: -CGFloat.cardWidth * CGFloat(showSlideNum))       // 移動
                .animation(showSlideMenu ? Animation.spring().delay(0.1) : Animation.spring().delay(0.5))   //アニメーションを指定（delay/trueのときは早め、falseのときはちょっと遅れて始まる）
            } //:ZStack
            
            Text(selectQ)
            
//MARK: - Button
             HStack{
               // ボタンの表示
               ForEach (1..<6) { num in
                    Button(action: {
                        if(self.showSlideNum < 9){
                            self.showSlideNum += 1
                        }
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
            // 戻るボタン
            Button(action: {
                if(self.showSlideNum > 0){
                    self.showSlideNum -= 1
                }
            }, label: {
                Text("戻る")
                    .foregroundColor(Color.white)
            }) //:button
            .frame(width: 100, height: 50)
            .background(Color.diagonalGradient)
            .cornerRadius(10)
            .shadow(radius: 3)
            
        } //:VStack
    } //:body
} //:view

struct big5SlideView_Previews: PreviewProvider {
    /*static let context = (UIApplication.shared.delegate as! AppDelegate)
    .persistentContainer.viewContext*/
    
    static var previews: some View {
        //let newData = PersonalInfoEntity(context: context)
        return big5SlideView()
        //.environment(\.managedObjectContext, context)
    }
}
