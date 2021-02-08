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
    
    static var preview: PersistentController = {
        let result = PersistentController()
        let viewContext = result.container.viewContext
        /// プレビュー用初期値の設定
        for i in 0..<5 {
            let newItem = PersonalDataEntity(context: viewContext)
            newItem.name = String(i)
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
        }()
    
    
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


