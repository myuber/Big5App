//
//  ContentView.swift
//  Big5
//
//  Created by がり on 2020/12/24.
//  Copyright © 2020 がり. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var showNewData = false
    
    var body: some View {
        ZStack{
        
//MARK: -body
            VStack {
                DataList()
                HStack{
                    Spacer()
                    Button(action: {
                        self.showNewData = true
                    }, label: {
                        Image(systemName: "person.crop.circle.badge.plus")
                            .resizable()
                            .scaledToFill()             //アスペクト比を維持してリサイズする
                            .frame(width: 50, height: 50)
                    })
                    
                    Spacer().frame(width: 30)
                }
                
                Spacer().frame(height: 30)
    //MARK: -admob
                // Admob用のフレームを用意
                Rectangle().frame(width: UIScreen.screenWidth, height:50)
                
            } //:VStack
//MARK: -NewData
            if showNewData {
                NewData(showNewData: $showNewData)
            }
            
        } //:ZStack
    } //:body
} //:view

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
