//
//  HomeView.swift
//  Big5App
//
//  Created by がり on 2021/02/12.
//

import SwiftUI

struct HomeView: View {
    @State var showNewData = false
    @State var showQuickMemo = false
    let persistentContainer = PersistentController.shared
    
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        ZStack{
        //MARK: -body
            VStack {
                ContentView(showNewData: $showNewData)
                    .environment(\.managedObjectContext, persistentContainer.container.viewContext)
                
                Spacer().frame(height: 30)
                
    //MARK: -admob
                /*
                // Admob用のフレームを用意
                Rectangle().frame(width: UIScreen.screenWidth, height:50)
                */
                
            } //:VStack
//MARK: -NewData
            if showNewData {
                NewData(showNewData: $showNewData)
                    .environment(\.managedObjectContext, persistentContainer.container.viewContext)
            }
            
        } //:ZStack
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
