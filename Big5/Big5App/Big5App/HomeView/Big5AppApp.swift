//
//  Big5AppApp.swift
//  Big5App
//
//  Created by がり on 2021/01/21.
//

import SwiftUI

@main
struct Big5AppApp: App {
    @State var showNewData = false
    @State var showQuickMemo = false
    let persistentContainer = PersistentController.shared
    
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
