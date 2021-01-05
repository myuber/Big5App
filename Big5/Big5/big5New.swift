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
    let quesList = ["質問1", "質問2", "質問3", "質問4", "質問5", "質問6"]
    var body: some View {
        ZStack {
            // NOTE: 画面をレンダリングするかで画面遷移を発生する
            if ObservedClass.isShowNextView {
                SubView(questionText: "質問")
            } else {
                Button(action: {
                    withAnimation() {
                        self.ObservedClass.isShowNextView.toggle()
                    }
                }) {
                    Text("SubViewへ遷移")
                }
            }
        }
    }
}

struct SubView: View {
    let questionText: String
    @EnvironmentObject var ObservedClass: ObservedClass
    
    var body: some View {
        // NOTE: 画面遷移アニメーションは自前で書く
        GeometryReader { geometory in
            ZStack {
                VStack {
                    Text(self.questionText)
                    Text(String(self.ObservedClass.isShowNextView))
                    Button(action: {
                        withAnimation() {
                            self.ObservedClass.isShowNextView.toggle()
                        }
                    }) {
                        Text("SubViewへ遷移")
                    }
                    
                }
            }
            .frame(width: geometory.size.width,
                   height: geometory.size.height)
            .background(Color.green)
            .animation(.easeInOut(duration: 0.4))
        }
        .transition(.move(edge: .trailing))
    }
}

struct big5New_Previews: PreviewProvider {
    static var previews: some View {
        big5New()
    }
}
