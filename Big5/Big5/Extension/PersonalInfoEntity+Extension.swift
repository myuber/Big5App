//
//  PersonalInfoEntityExtension.swift
//  Big5
//
//  Created by がり on 2020/12/27.
//  Copyright © 2020 がり. All rights reserved.
//

import CoreData
import SwiftUI

// 41番を参考にcreate関数を実装する
extension PersonalInfoEntity: Identifiable{}
extension PersonalInfoEntity {
    
    static func create(in managedObjectContext: NSManagedObjectContext,
                       name: String,
                       kana: String,
                       nickname: String,
                       sex: Int16,
                       birthday: Date,
                       from: String,
                       job: String,
                       like: String,
                       dislike: String,
                       tel: String,
                       mail: String,
                       explanation: String){
        let personalData = self.init(context: managedObjectContext)
        print(name)
        personalData.name = name
        personalData.kana = kana
        personalData.nickname = nickname
        personalData.sex = sex
        personalData.birthday = birthday
        personalData.from = from
        personalData.job = job
        personalData.like = like
        personalData.dislike = dislike
        personalData.tel = tel
        personalData.mail = mail
        personalData.explanation = explanation
        personalData.id = UUID().uuidString
        
        do {
            try managedObjectContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    enum sex: Int16 {
        case male              // 男性
        case female            // 女性
        case other             //その他
    }
}

struct PersonalInfoEntityExtension_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
