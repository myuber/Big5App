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
    
/*
    enum big5Category : String, CaseIterable{
        case big5Agree       //協調性
        case big5Extra       //外向性
        case big5Open        //開放性
        case big5Conscien    //誠実性
        case big5Neuro       //神経症的傾向
        case big5NotAgree    //非協調性
        case big5NotExtra    //非外向性
        case big5NotOpen     //非開放性
        case big5NotConscien //非誠実性
        case big5NotNeuro    //非神経症的傾向
        
        func Big5Question() -> String {
            switch self {
                case .big5Agree:       //協調性
                    return "この人は面倒見がいい性格ですか？"
                case .big5Extra:       //外向性
                    return "この人は他人と一緒にいることが好きですか?"
                case .big5Open:        //開放性
                    return "この人は好奇心が強く、新しいことにチャレンジしたりするのが好きですか？"
                case .big5Conscien:    //誠実性
                    return "この人は物ごとに真面目にコツコツ取り組むことができますか？"
                case .big5Neuro:       //神経症的傾向
                    return "この人は心配ごとが多く、怖がりでメンタルが弱いタイプですか？"
                case .big5NotAgree:    //非協調性
                    return "この人は思ったことを躊躇せずにストレートに言える人ですか？"
                case .big5NotExtra:    //非外向性
                    return "この人は一人でいる方が落ち着くタイプですか？"
                case .big5NotOpen:     //非開放性
                    return "この人は保守的で頑固な一面がありますか？"
                case .big5NotConscien: //非誠実性
                    return "この人は無計画で、思いつきで行動することがありますか？"
                case .big5NotNeuro:    //非神経症的傾向
                    return "この人は常に悩みがなく、リラックスしていることが多いですか？"
            }
        }
    }*/
}

struct PersonalInfoEntityExtension_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
