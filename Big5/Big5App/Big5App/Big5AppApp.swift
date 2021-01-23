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
            ContentView()
                .environment(\.managedObjectContext,
                             persistentContainer.container.viewContext)
        }
    }
}
