//
//  PersonalDataInput.swift
//  Big5
//
//  Created by がり on 2020/12/27.
//  Copyright © 2020 がり. All rights reserved.
//

import SwiftUI

struct PersonalDataInput: View {
    // 保存処理に必要なコンテキスト
    @Environment(\.managedObjectContext) var viewContext
    
    @State var name: String = ""
    @State var kana: String = ""
    @State var nickname: String = ""
    @State var sex: Int16 = 0
    @State var birthday: Date = Date()
    @State var from: String = ""
    @State var job: String = ""
    @State var like: String = ""
    @State var dislike: String = ""
    @State var tel: String = ""
    @State var mail: String = ""
    @State var explanation: String = ""
    
    fileprivate func addNewData() {
        PersonalInfoEntity.create(in: self.viewContext,
                                  name: self.name,
                                  kana: self.kana,
                                  nickname: self.nickname,
                                  sex: self.sex,
                                  birthday: self.birthday,
                                  from: self.from,
                                  job: self.job,
                                  like: self.like,
                                  dislike: self.dislike,
                                  tel: self.tel,
                                  mail: self.mail,
                                  explanation: self.explanation)
        self.name = ""
    }
    
    fileprivate func cancelData() {
        self.name = ""
    }
    
    fileprivate func save() {
        do {
            try self.viewContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Spacer()
                    Image("image01").resizable().frame(width: 100, height: 100)
                    Spacer()
                }
                //----------- 基本情報 -----------
                Section(header: Text("基本情報")){
                    HStack {
                        Text("名前")
                            .frame(width: 120, alignment: .leading)
                        TextField("お名前", text: $name)
                    }
                    HStack {
                        Text("フリガナ")
                            .frame(width: 120, alignment: .leading)
                        TextField("フリガナ", text: $kana)
                    }
                    HStack {
                        Text("ニックネーム")
                            .frame(width: 120, alignment: .leading)
                        TextField("ニックネーム", text: $nickname)
                    }
                    HStack {
                        Text("性別")
                            .frame(width: 120, alignment: .leading)
                        Picker(selection: $sex, label: Text("性別")){
                            Text("男性").tag(0)
                            Text("女性").tag(1)
                            Text("その他").tag(2)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .labelsHidden()
                    }
                    DatePicker(selection: $birthday,
                               displayedComponents: .date,
                               label: {Text("誕生日")}
                    ) // 多分Xcodeをアップデートすれば使えるカレンダー型のピッカー.datePickerStyle(GraphicalDatePickerStyle())
                    
                    HStack {
                        Text("出身地")
                            .frame(width: 120, alignment: .leading)
                        TextField("〇〇県〇〇市", text: $from)
                    }
                    HStack {
                        Text("職業")
                            .frame(width: 120, alignment: .leading)
                        TextField("会社員", text: $job)
                    }
                    HStack {
                        Text("好きなもの")
                            .frame(width: 120, alignment: .leading)
                        TextField("好きなもの", text: $like)
                    }
                    HStack {
                        Text("嫌いなもの")
                            .frame(width: 120, alignment: .leading)
                        TextField("嫌いなもの", text: $dislike)
                    }
                }
                //----------- 連絡先 -----------
                Section(header: Text("連絡先")) {
                    HStack {
                        Text("電話番号")
                            .frame(width: 120, alignment: .leading)
                        TextField("000-0000-0000", text: $tel)
                            .keyboardType(.phonePad)
                    }
                    HStack {
                        Text("メール")
                            .frame(width: 120, alignment: .leading)
                        TextField("xxxxxxxx@xxx.jp", text: $mail)
                    }
                }
                //----------- メモ -----------
                Section(header: Text("追加情報")) {
                    TextField("最近話したことなどをメモしよう", text: $explanation)
                }
                //----------- 登録ボタン -----------
                HStack(alignment: .center) {
                    Spacer()
                    Button(action: {
                        self.cancelData()
                    }){
                        HStack{
                            Image(systemName: "minus.circle.fill")
                            Text("キャンセル")
                                .font(.headline)
                        }.foregroundColor(.red)
                    }
                    Spacer()
                }
            }.navigationBarTitle("情報の追加")
            .navigationBarItems(trailing: Button(action: {
                // 63番を参考にcreate関数を実装する
            }){
                Text("追加")
            })
            .frame(width: 375) //375にしておくと、iPhon8でも対応できる
        }
    }
}

struct PersonalDataInput_Previews: PreviewProvider {
    static let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    static var previews: some View {
        PersonalDataInput()
            .environment(\.managedObjectContext, context)
    }
}
