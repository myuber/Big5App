//
//  ObservedClass.swift
//  Big5
//
//  Created by がり on 2021/01/05.
//  Copyright © 2021 がり. All rights reserved.
//

import SwiftUI

class ObservedClass: ObservableObject {
     @Published var quesList = [
        "この人は面倒見がいい性格ですか？",
        "この人は他人と一緒にいることが好きですか？",
        "この人は好奇心が強く、新しいことにチャレンジしたりするのが好きですか？",
        "この人は物ごとに真面目にコツコツ取り組むことができますか？",
        "この人は心配ごとが多く、怖がりでメンタルが弱いタイプですか？",
        "この人は思ったことを躊躇せずにストレートに言える人ですか？",
        "この人は一人でいる方が落ち着くタイプですか？",
        "この人は保守的で頑固な一面がありますか？",
        "この人は無計画で、思いつきで行動することがありますか？",
        "この人は常に悩みがなく、リラックスしていることが多いですか？"
    ]
     @Published var quesNum = 0
    
    enum big5Category:String, CaseIterable {
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
    }
    
}
        

