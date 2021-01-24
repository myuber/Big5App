//
//  Big5AppApp.swift
//  Big5App
//
//  Created by がり on 2021/01/21.
//

import SwiftUI

@main
struct Big5AppApp: App {
    
    let persistentContainer = PersistentController.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                VStack{
                    NavigationLink(destination:
                                    NewData().environment(\.managedObjectContext,
                                        persistentContainer.container.viewContext)
                    ) {
                        Text("インプット")
                    } //:NavigationLink
                    
                    NavigationLink(destination:
                                    ContentView().environment(\.managedObjectContext,
                                     persistentContainer.container.viewContext)
                    ) {
                        Text("一覧")
                    } //:NavigationLink
                } //:VStack
            } //:NavigationView
        }
    }
}
