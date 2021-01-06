//
//  big5New.swift
//  Big5
//
//  Created by がり on 2021/01/05.
//  Copyright © 2021 がり. All rights reserved.
//

import SwiftUI

struct big5New: View {
    @EnvironmentObject var ObservedClass: ObservedClass
    
    
    @State private var isActive = false
    
    var body: some View {
        let gradient = LinearGradient(gradient: Gradient(colors: [Color.tPurple, Color.tSky]),
                                     startPoint: .top,
                                     endPoint: .bottom)
        let diagonalGradient = LinearGradient(gradient: Gradient(colors: [Color.tPurple, Color.tSky]),
                                              startPoint: .topLeading,
                                              endPoint: .bottomTrailing)
        
        return NavigationView {
            ZStack {
                // 背景をグラデーションに設定
                gradient.edgesIgnoringSafeArea(.all)
            
                VStack {
                    Text(ObservedClass.quesList[0])
                    
                    NavigationLink(destination: MidView(questionNum: 1, isFirstViewActive: $isActive), isActive: $isActive) {
                        ForEach (1..<6) { num in
                            Button(action: {
                                self.isActive = true
                            }, label: {
                                Text(String(num))
                                    .foregroundColor(Color.white)
                            })
                            .frame(width: 50, height: 50)
                            .background(diagonalGradient)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        }
                    }
                }
                
            }
        }.navigationBarTitle("First View")
    }
}


struct MidView: View {
    @EnvironmentObject var ObservedClass: ObservedClass
    
    let questionNum: Int
    @State private var isActive = false
    @Binding var isFirstViewActive: Bool
    
    var body: some View {
        let gradient = LinearGradient(gradient: Gradient(colors: [Color.tPurple, Color.tSky]),
        startPoint: .top,
        endPoint: .bottom)
        
        return ZStack {
            // 背景をグラデーションに設定
            gradient.edgesIgnoringSafeArea(.all)
            VStack {
                Text(ObservedClass.quesList[self.questionNum])
                NavigationLink(destination: EndView(questionNum: 2, isFirstViewActive: $isFirstViewActive), isActive: $isActive){
                    Button(action: {
                        self.isActive = true
                    }, label: {
                        Text("Go to MidView")
                    })
                }
                .isDetailLink(false)
            }
        }
    }
}


struct EndView: View {
    @EnvironmentObject var ObservedClass: ObservedClass
    
    let questionNum: Int
    @Binding var isFirstViewActive: Bool
    
    var body: some View {
        let gradient = LinearGradient(gradient: Gradient(colors: [Color.tPurple, Color.tSky]),
        startPoint: .top,
        endPoint: .bottom)
        
        return ZStack {
            // 背景をグラデーションに設定
            gradient.edgesIgnoringSafeArea(.all)
            VStack {
                Text(ObservedClass.quesList[self.questionNum])
                Button(action: {
                    self.isFirstViewActive = false
                }, label: {
                    Text("Back to FirstView")
                })
            }
        }
    }
}

struct big5New_Previews: PreviewProvider {
    static var previews: some View {
        big5New()
    }
}
