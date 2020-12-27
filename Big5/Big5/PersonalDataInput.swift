//
//  PersonalDataInput.swift
//  Big5
//
//  Created by がり on 2020/12/27.
//  Copyright © 2020 がり. All rights reserved.
//

import SwiftUI

struct PersonalDataInput: View {
    @State var name: String = ""
    @State var kana: String = ""
    @State var nickname: String = ""
    @State var sex: String = ""
    @State var birthday: String = ""
    @State var from: String = ""
    @State var job: String = ""
    @State var explanation: String = ""
    @State var like: String = ""
    @State var dislike: String = ""
    @State var tel: String = ""
    @State var mail: String = ""
    
    fileprivate func addNewData() {
        self.name = ""
    }
    
    fileprivate func cancelData() {
        self.name = ""
    }
    
    var body: some View {
        VStack {
            VStack {
                //----------- 基本情報 -----------
                HStack {
                    Text("名前")
                    TextField("お名前", text: $name)
                }
                HStack {
                    Text("フリガナ")
                    TextField("フリガナ", text: $kana)
                }
                HStack {
                    Text("ニックネーム")
                    TextField("ニックネーム", text: $nickname)
                }
                HStack {
                    Text("性別")
                    TextField("男女", text: $sex)
                }
                HStack {
                    Text("誕生日")
                    TextField("1990年1月1日", text: $birthday)
                }
                HStack {
                    Text("出身地")
                    TextField("〇〇県〇〇市", text: $from)
                }
                HStack {
                    Text("職業")
                    TextField("会社員", text: $job)
                }
                HStack {
                    Text("どんな人？")
                    TextField("どんな人か説明", text: $explanation)
                }
                HStack {
                    Text("好きなもの")
                    TextField("好きなもの", text: $like)
                }
                HStack {
                    Text("嫌いなもの")
                    TextField("嫌いなもの", text: $dislike)
                }
            }
            //----------- 連絡先 -----------
            VStack {
                HStack {
                    Text("電話番号")
                    TextField("000-0000-0000", text: $tel)
                }
                HStack {
                    Text("メールアドレス")
                    TextField("xxxxxxxx@xxx.jp", text: $mail)
                }
            }
            HStack {
                //----------- 登録ボタン -----------
                Button(action: {
                    self.addNewData()
                }){
                    Text("登録")
                }
                Button(action: {
                    self.cancelData()
                }){
                    Text("キャンセル")
                }
            }
        }
    }
}

struct PersonalDataInput_Previews: PreviewProvider {
    static var previews: some View {
        PersonalDataInput()
    }
}
