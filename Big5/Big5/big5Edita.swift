//
//  big5Edit.swift
//  Big5
//
//  Created by がり on 2020/12/31.
//  Copyright © 2020 がり. All rights reserved.
//

import SwiftUI
import Charts

struct big5Edit: View {
    @ObservedObject var personalData: PersonalInfoEntity
    // 保存処理に必要なコンテキスト
    @Environment(\.managedObjectContext) var viewContext
    
    
    @State var ba:Int16 = 1
    
    var body: some View {
        VStack {
            
            HStack{
                Stepper(value: $personalData.big5Agree, in: -4...4) {
                    Text("協調性")
                }
                Text(String(personalData.big5Agree))
            }
            HStack{
                Stepper(value: $personalData.big5Extra, in: -4...4) {
                    Text("外向性")
                }
                Text(String(personalData.big5Extra))
            }
            HStack{
                Stepper(value: $personalData.big5Open, in: -4...4) {
                    Text("開放性")
                }
                Text(String(personalData.big5Open))
            }
            HStack{
                Stepper(value: $personalData.big5Conscien, in: -4...4) {
                    Text("誠実性")
                }
                Text(String(personalData.big5Conscien))
            }
            HStack{
                Stepper(value: $personalData.big5Neuro, in: -4...4) {
                    Text("神経症的傾向")
                }
                Text(String(personalData.big5Neuro))
            }
        }
    }
}


struct big5Edit_Previews: PreviewProvider {
    static let context = (UIApplication.shared.delegate as! AppDelegate)
            .persistentContainer.viewContext
    
    static var previews: some View {
        let newData = PersonalInfoEntity(context: context)
        return big5Edit(personalData: newData)
            .environment(\.managedObjectContext, context)
    }
    
}
