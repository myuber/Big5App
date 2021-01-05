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
        NavigationView {
            VStack {
                Text(ObservedClass.quesList[0])
                NavigationLink(destination: MidView(questionNum: 1, isFirstViewActive: $isActive), isActive: $isActive) {
                    Button(action: {
                        self.isActive = true
                    }, label: {
                        Text("Go to MidView")
                    })
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


struct EndView: View {
    @EnvironmentObject var ObservedClass: ObservedClass
    
    let questionNum: Int
    @Binding var isFirstViewActive: Bool
    
    var body: some View {
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

struct big5New_Previews: PreviewProvider {
    static var previews: some View {
        big5New()
    }
}
