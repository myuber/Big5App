//
//  Big5AppApp.swift
//  Big5App
//
//  Created by がり on 2021/01/18.
//

import SwiftUI

@main
struct Big5AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
