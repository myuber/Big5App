//
//  big5SlideView.swift
//  
//
//  Created by がり on 2021/01/08.
//

import SwiftUI

struct big5SlideView: View {
    @ObservedObject var personalData: PersonalInfoEntity
    // 保存処理に必要なコンテキスト
    @Environment(\.managedObjectContext) var viewContext
    
    //@Binding var showSlideMenu: Bool
    @State var showSlideMenu: Bool = false
    @State var showSlideNum: Int = 0
    
    @State var selectQ = ""
    @EnvironmentObject var observedClass: ObservedClass
    
// MARK: - Body
    var body: some View {
        ZStack {
            // 背景でグラデーションを配置
            Color.gradient.edgesIgnoringSafeArea(.all)
            
            // スクロールを実装
            ScrollView (.vertical){
                VStack {
//MARK: -BackButton
                    HStack{
                        Spacer()
                        Image(systemName: "arrowshape.turn.up.left")
                            .foregroundColor(Color.white)
                        // 戻るボタン
                        Button(action: {
                            if(self.showSlideNum > 0){
                                self.showSlideNum -= 1
                            }
                        }, label: {
                            Text("戻る")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .lineLimit(nil)
                        }) //:button
                            .padding(.trailing, 20.0)
                        
                    }.frame(width: UIScreen.screenWidth)
                    
//MARK: - Card
                    // 質問文をカードのようにスライドで表示するView
                    HStack(spacing: 50) {
                        // ObservedClassのenumを全て取得して、big5QuesCardで表示
                        ForEach(ObservedClass.big5Category.allCases, id: \.self) { (category) in
                            big5QuesCard(QuestionWord: category.Big5Question())
                        }
                        
                    } //:HStack
                        .offset(x: UIScreen.screenWidth * 4.5)
                        .offset(x: -UIScreen.screenWidth * CGFloat(showSlideNum))       // 移動
                        .animation(showSlideMenu ? Animation.spring().delay(0.1) : Animation.spring().delay(0.5))   //アニメーションを指定（delay/trueのときは早め、falseのときはちょっと遅れて始まる）
                        .padding(.bottom, 30.0)
                
                            
//MARK: - Button
                     HStack{
                       // // それぞれのBig5の数値を入力する1〜5の数字ボタンを表示
                       ForEach (1..<6) { num in
                            Button(action: {
                                if(self.showSlideNum < 9){
                                    // 質問数に応じてBig5の値を格納していく
                                    switch self.showSlideNum {
                                        case 0:
                                            self.personalData.big5Agree = Int16(num)
                                        case 1:
                                            self.personalData.big5Extra = Int16(num)
                                        case 2:
                                            self.personalData.big5Open = Int16(num)
                                        case 3:
                                            self.personalData.big5Conscien = Int16(num)
                                        case 4:
                                            self.personalData.big5Neuro = Int16(num)
                                        case 5:
                                            self.personalData.big5NotAgree = Int16(num)
                                        case 6:
                                            self.personalData.big5NotExtra = Int16(num)
                                        case 7:
                                            self.personalData.big5NotOpen = Int16(num)
                                        case 8:
                                            self.personalData.big5NotConscien = Int16(num)
                                        case 9:
                                            self.personalData.big5NotNeuro = Int16(num)
                                        // defaultは発生しない(1ページ目に戻るように設定しておく)
                                        default:
                                            self.showSlideNum = 0
                                    }
                                    // 次の質問へ進む
                                    self.showSlideNum += 1
                                }
                           }, label: {
                               Text(String(num))
                                   .foregroundColor(Color.white)
                           }) //:button
                                // スクリーンの大きさ-70を5等分した大きさに設定
                                .frame(width: (UIScreen.screenWidth-70)/5, height: (UIScreen.screenWidth-70)/5)
                                //
                               .background(Color.diagonalGradient)
                               .cornerRadius(10)
                               .shadow(radius: 3)
                       } //:ForEach
                    } //:HStack
//MARK: -Line
                    HStack {
                        Text("1.当てはまらない")
                        .foregroundColor(.white)
                        Color.white
                            .frame(width: 70, height: 1)
                        Text("5.当てはまる")
                        .foregroundColor(.white)
                    } //: HStack
                    .padding(.top, 15)
                    

                } //:VStack
            } //:ScrollView
        } //:ZStack
    } //:body
} //:view

struct big5SlideView_Previews: PreviewProvider {
    static let context = (UIApplication.shared.delegate as! AppDelegate)
    .persistentContainer.viewContext
    
    static var previews: some View {
        let newData = PersonalInfoEntity(context: context)
        return big5SlideView(personalData: newData)
        .environment(\.managedObjectContext, context)
    }
}
