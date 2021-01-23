//
//  Persistence.swift
//  Big5App
//
//  Created by がり on 2021/01/21.
// 下記のYouTubeを参照
// https://www.youtube.com/watch?v=091Mdv_Rjb4

import CoreData

struct PersistentController {
    static let shared = PersistentController()
    
    let container: NSPersistentContainer
    
    
    init() {
        container = NSPersistentContainer(name: "Big5App") //xcdatamodeldのファイル名にする
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved \(error)")
            }
        }
    }
}
