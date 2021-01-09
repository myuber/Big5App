//
//  big5New.swift
//  Big5
//
//  Created by がり on 2021/01/05.
//  Copyright © 2021 がり. All rights reserved.
//
/*
import SwiftUI

struct big5New: View {
    @EnvironmentObject var ObservedClass: ObservedClass
    
    @State private var isActive = false
    @State private var numnum = 0
    
    var body: some View {
        let gradient = LinearGradient(gradient: Gradient(colors: [Color.tPurple, Color.tSky]),
                                     startPoint: .top,
                                     endPoint: .bottom)
        
        return NavigationView {
            ZStack {
                // 背景をグラデーションに設定
                gradient.edgesIgnoringSafeArea(.all)
            
                VStack {
                    NavigationLink(destination: QuesView(questionNum: 0, isFirstViewActive: $isActive)){
                        Text("Big5診断を開始する")
                    }
                    
                }
            }
        }.navigationBarTitle("First View")
    }
}


struct QuesView: View {
    @EnvironmentObject var ObservedClass: ObservedClass
    
    let questionNum: Int
    @State private var isActive = false
    @Binding var isFirstViewActive: Bool
    @State var numnum: Int = 0
    
    @Binding var showSlideMenu: Bool
    
    var body: some View {
        let gradient = LinearGradient(gradient: Gradient(colors: [Color.tPurple, Color.tSky]),
        startPoint: .top,
        endPoint: .bottom)
        
        let diagonalGradient = LinearGradient(gradient: Gradient(colors: [Color.tPurple, Color.tSky]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
        
        return ZStack {
            // 背景をグラデーションに設定
            gradient.edgesIgnoringSafeArea(.all)
            VStack {
                Text(ObservedClass.quesList[self.questionNum])
                HStack{
                    // ボタンの表示
                    ForEach (1..<6) { num in
                        Button(action: {
                            self.isActive = true
                            self.numnum = num
                            self.destination = QuesViewOdd()//(questionNum: num, isFirstViewActive: self.$isActive)
                            
                        }, label: {
                            Text(String(num))
                                .foregroundColor(Color.white)
                        }) //:button
                        .frame(width: 50, height: 50)
                        .background(diagonalGradient)
                        .cornerRadius(10)
                        .shadow(radius: 3)
                    } //:ForEach
                } //:HStack
                
                if (self.numnum < 5){
                    NavigationLink(destination: destination, isActive: $isActive){
                        EmptyView()
                    }.isDetailLink(false)
                } else {
                    NavigationLink(destination: EndView(questionNum: 5, isFirstViewActive: $isActive), isActive: $isActive){
                        EmptyView()
                    }.isDetailLink(false)
                } //: if_else
                
            } //: VStack
        } //: ZStack
    } // :body
} //:struct


struct QuesViewOdd: View {
    @EnvironmentObject var ObservedClass: ObservedClass
    
    let questionNum: Int
    @State private var isActive = false
    @Binding var isFirstViewActive: Bool
    @State var numnum: Int = 0
    
    @State var destinationOdd: QuesView? = nil
    
    var body: some View {
        Text("Hello")
    }
}



struct big5New_Previews: PreviewProvider {
    static var previews: some View {
        big5New()
    }
}
 */
