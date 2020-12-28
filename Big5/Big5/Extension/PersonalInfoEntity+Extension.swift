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
extension PersonalInfoEntity: Identiabal{}
extension PersonalInfoEntity {
    
    static func create(in managedObjectContext)
    
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
