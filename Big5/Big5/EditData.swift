//
//  EditData.swift
//  Big5
//
//  Created by がり on 2020/12/29.
//  Copyright © 2020 がり. All rights reserved.
//

import SwiftUI

struct EditData: View {
    @ObservedObject var personalData: PersonalInfoEntity
    // 保存処理に必要なコンテキスト
    @Environment(\.managedObjectContext) var viewContext
    
    // Big5Editを表示するSheet判定用の変数
    @State var showBig5EditSheet = false
    
    
    fileprivate func delete() {
        viewContext.delete(personalData)
        save()
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
                VStack {
                    HStack {
                        Spacer()
                        Image("image01").resizable().frame(width: 100, height: 100)
                        Spacer()
                    }
                    Button(action: {
                        self.showBig5EditSheet = true
                    }){
                        Image(systemName: "plus")
                    }.sheet(isPresented: $showBig5EditSheet) {
                        big5Edit(personalData: self.personalData)
                            .environment(\.managedObjectContext, self.viewContext)
                    }
                    
                }
                //----------- 基本情報 -----------
                Section(header: Text("基本情報")){
                    HStack {
                        Text("名前")
                            .frame(width: 120, alignment: .leading)
                        TextField("お名前", text: Binding($personalData.name, "new name"))
                    }
                    HStack {
                        Text("フリガナ")
                            .frame(width: 120, alignment: .leading)
                        TextField("フリガナ", text: Binding($personalData.kana, "new kana"))
                    }
                    HStack {
                        Text("ニックネーム")
                            .frame(width: 120, alignment: .leading)
                        TextField("ニックネーム", text: Binding($personalData.nickname, "new nickname"))
                    }
                    HStack {
                        Text("性別")
                            .frame(width: 120, alignment: .leading)
                        Picker(selection: Binding($personalData.sex), label: Text("性別")){
                            Text("男性").tag(0)
                            Text("女性").tag(1)
                            Text("その他").tag(2)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .labelsHidden()
                    }
                    DatePicker(selection: Binding($personalData.birthday, Date()),
                               displayedComponents: .date,
                               label: {Text("誕生日")}
                    ) // 多分Xcodeをアップデートすれば使えるカレンダー型のピッカー.datePickerStyle(GraphicalDatePickerStyle())
                    
                    HStack {
                        Text("出身地")
                            .frame(width: 120, alignment: .leading)
                        TextField("〇〇県〇〇市", text: Binding($personalData.from, "new from"))
                    }
                    HStack {
                        Text("職業")
                            .frame(width: 120, alignment: .leading)
                        TextField("会社員", text: Binding($personalData.job, "new job"))
                    }
                    HStack {
                        Text("好きなもの")
                            .frame(width: 120, alignment: .leading)
                        TextField("好きなもの", text: Binding($personalData.like, "new like"))
                    }
                    HStack {
                        Text("嫌いなもの")
                            .frame(width: 120, alignment: .leading)
                        TextField("嫌いなもの", text: Binding($personalData.dislike, "new dislike"))
                    }
                }
                //----------- 連絡先 -----------
                Section(header: Text("連絡先")) {
                    HStack {
                        Text("電話番号")
                            .frame(width: 120, alignment: .leading)
                        TextField("000-0000-0000", text: Binding($personalData.tel, "new tel"))
                            .keyboardType(.phonePad)
                    }
                    HStack {
                        Text("メール")
                            .frame(width: 120, alignment: .leading)
                        TextField("xxxxxxxx@xxx.jp", text: Binding($personalData.mail, "new mail"))
                    }
                }
                //----------- メモ -----------
                Section(header: Text("追加情報")) {
                    TextField("最近話したことなどをメモしよう", text: Binding($personalData.explanation, "new explanation"))
                }
                //----------- 登録ボタン -----------
                HStack(alignment: .center) {
                    Spacer()
                    Button(action: {
                        self.delete()
                    }){
                        HStack{
                            Image(systemName: "minus.circle.fill")
                            Text("削除")
                                .font(.headline)
                        }.foregroundColor(.red)
                    }
                    Spacer()
                }
            }.navigationBarTitle("情報の編集")
            .navigationBarItems(trailing: Button(action: {
                self.save()
            }){
                Text("保存")
            })
            .frame(width: 375) //375にしておくと、iPhon8でも対応できる
        }
    }
}

struct EditData_Previews: PreviewProvider {
    static let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    static var previews: some View {
        let newData = PersonalInfoEntity(context: context)
        return EditData(personalData: newData)
            .environment(\.managedObjectContext, context)
    }
}

