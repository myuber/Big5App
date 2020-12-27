//
//  PersonalInfoEntityExtension.swift
//  Big5
//
//  Created by がり on 2020/12/27.
//  Copyright © 2020 がり. All rights reserved.
//

import CoreData
import SwiftUI

extension PersonalInfoEntity {
    enum sex: Int16 {
        case male              // 男性
        case female           // 女性
    }
}

struct PersonalInfoEntityExtension_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
