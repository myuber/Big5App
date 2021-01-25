//
//  big5SlideView.swift
//  Big5App
//
//  Created by がり on 2021/01/24.
//

import SwiftUI

struct big5SlideView: View {
    @ObservedObject var personalData: PersonalDataEntity
    // 保存処理に必要なコンテキスト
    @Environment(\.managedObjectContext) private var viewContext
    
    // big5SlideViewを表示/非表示を切り替える変数
   @Binding var showbig5SlideView: Bool
   
   // Viewを閉じるための変数
   @Environment (\.presentationMode) var presentationMode
   
   @State var showAnimation: Bool = false
   
   //@Binding var showSlideMenu: Bool
   @State var showSlideMenu: Bool = false
   @State var showSlideNum: Int = 0
   
   @State var selectQ = ""
   @EnvironmentObject var observedClass: ObservedClass
   
// MARK: - Body
   var body: some View {
       ZStack {
// MARK: - Background
       Color.black.opacity(0.85)
           .edgesIgnoringSafeArea(.all)
           .onTapGesture {
               self.showbig5SlideView = false
           }
           
           ZStack {
               // 背景でグラデーションを配置
               RoundedRectangle(cornerRadius: 25)
                   .fill(Color.gradient)
                   .frame(width: UIScreen.screenWidth)
                   .edgesIgnoringSafeArea(.bottom)
               
           VStack{
// MARK: - User View
               ZStack {

                   Circle()
                       .fill(Color.white)
                       .frame(width: 120, height: 120)

                   Image("image01")
                       .resizable()
                       .scaledToFill()
                       .frame(width: 110, height: 110)
                       .clipShape(Circle())
               } //: ZStack
                   .padding(.top, -60)
                   .scaleEffect(showAnimation ? 1 : 0)
               
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
                                   if(self.showSlideNum < 10){
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
                                           case 9: // 最後の質問が終わったらそのままViewを閉じる
                                               self.personalData.big5NotNeuro = Int16(num)
                                               
                                               // 全ての値を計算する
                                               self.personalData.big5Agree -= self.personalData.big5NotAgree
                                               self.personalData.big5Extra -= self.personalData.big5NotExtra
                                               self.personalData.big5Open -= self.personalData.big5NotOpen
                                               self.personalData.big5Conscien -= self.personalData.big5NotConscien
                                               self.personalData.big5Neuro -= self.personalData.big5NotNeuro
                                           
                                               // Viewを閉じる
                                               self.showbig5SlideView = false
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
                       .scaleEffect(showAnimation ? 1 : 0)
   //MARK: -Line
                       HStack {
                           Text("1.当てはまらない")
                           .foregroundColor(.white)
                           Color.white
                               .frame(width: 70, height: 1)
                           Text("5.当てはまる")
                           .foregroundColor(.white)
                       } //: HStack
                       .padding(.top, 5)
                       .scaleEffect(showAnimation ? 1 : 0)
                       
                       VStack{
                           HStack {
                               Text(String(self.personalData.big5Agree))
                               Text(String(self.personalData.big5Extra))
                               Text(String(self.personalData.big5Open))
                               Text(String(self.personalData.big5Conscien))
                               Text(String(self.personalData.big5Neuro))
                               
                           }
                           HStack {
                               Text(String(self.personalData.big5NotAgree))
                               Text(String(self.personalData.big5NotExtra))
                               Text(String(self.personalData.big5NotOpen))
                               Text(String(self.personalData.big5NotConscien))
                               Text(String(self.personalData.big5NotNeuro))
                               
                           }
                       } //:VStack
                   } //:VStack
               } //:VStack
           } //:ZStack
               .padding(.top, 130)
       } //:ZStack
           .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
           .onAppear(perform: {
               withAnimation{
                   self.showAnimation = true
               }
           })
   } //:body
} //:view

/*

struct big5SlideView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    
    }
}
*/
