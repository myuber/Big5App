//
//  NewData.swift
//  Big5App
//
//  Created by がり on 2021/01/24.
//

import SwiftUI

struct NewData: View {
    // Viewの表示を切り替える変数
    @Binding var showNewData: Bool
    
    // 保存処理に必要なコンテキスト
    @Environment(\.managedObjectContext) private var viewContext
    
    let UUID: String =  NSUUID().uuidString
    @State var name: String = ""
    @State var kana: String = ""
    @State var nickname: String = ""
    @State var sex: String = ""
    @State var birthday: Date = Date()
    @State var from: String = ""
    @State var job: String = ""
    @State var like: String = ""
    @State var dislike: String = ""
    @State var tel: String = ""
    @State var mail: String = ""
    @State var explanation: String = ""
    
    
    fileprivate func addNewData() {
        withAnimation {
            let newData = PersonalDataEntity(context: viewContext)
            newData.id = self.UUID
            newData.name = self.name
            newData.kana = self.kana
            newData.nickname = self.nickname
            newData.sex = self.sex
            newData.birthday = self.birthday
            newData.from = self.from
            newData.job = self.job
            newData.like = self.like
            newData.dislike = self.dislike
            newData.tel = self.tel
            newData.mail = self.mail
            newData.explanation = self.explanation
            newData.id = "\(Date())"
            
            saveContext()
            
            self.name = ""
            self.kana = ""
            self.nickname = ""
            self.sex = ""
            self.birthday = Date()
            self.from = ""
            self.job = ""
            self.like = ""
            self.dislike = ""
            self.tel = ""
            self.mail = ""
            self.explanation = ""
        }
    }
    
    fileprivate func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error: \(error)")
        }
    }
    
    fileprivate func cancelData() {
        self.name = ""
        self.kana = ""
        self.nickname = ""
        self.sex = ""
        self.birthday = Date()
        self.from = ""
        self.job = ""
        self.like = ""
        self.dislike = ""
        self.tel = ""
        self.mail = ""
        self.explanation = ""
    }
    
    var body: some View {
        // Formの背景設定を一度クリアにする
        UITableView.appearance().backgroundColor = .clear
        
        return NavigationView {
            Form {
                HStack {
                    Spacer()
                    Image(systemName: "person").resizable().frame(width: 100, height: 100)
                    Spacer()
                }
                //----------- 基本情報 -----------
                Section(header: Text("基本情報")){
                    HStack {
                        Text("名前")
                            .frame(width: 120, alignment: .leading)
                        ZStack {
                            if name.isEmpty { Text("お名前").foregroundColor(Color.gray) }
                            TextField("", text: $name)
                        }
                    }.foregroundColor(Color.black)
                    HStack {
                        Text("フリガナ")
                            .frame(width: 120, alignment: .leading)
                        ZStack {
                            if kana.isEmpty { Text("フリガナ").foregroundColor(Color.gray) }
                            TextField("", text: $kana)
                        }
                    }.foregroundColor(Color.black)
                    HStack {
                        Text("ニックネーム")
                            .frame(width: 120, alignment: .leading)
                        ZStack {
                            if nickname.isEmpty { Text("ニックネーム").foregroundColor(Color.gray) }
                            TextField("", text: $nickname)
                        }
                    }.foregroundColor(Color.black)
                    DatePicker(selection: $birthday,
                               displayedComponents: .date,
                               label: {Text("誕生日")}
                    ).foregroundColor(Color.black)
                    // 多分Xcodeをアップデートすれば使えるカレンダー型のピッカー.datePickerStyle(GraphicalDatePickerStyle())
                    
                    HStack {
                        Text("出身地")
                            .frame(width: 120, alignment: .leading)
                        ZStack {
                            if from.isEmpty { Text("〇〇県〇〇市").foregroundColor(Color.gray) }
                            TextField("", text: $from)
                        }
                    }.foregroundColor(Color.black)
                    HStack {
                        Text("職業")
                            .frame(width: 120, alignment: .leading)
                        ZStack {
                            if job.isEmpty { Text("会社員").foregroundColor(Color.gray) }
                            TextField("", text: $job)
                        }
                    }.foregroundColor(Color.black)
                    HStack {
                        Text("好きなもの")
                            .frame(width: 120, alignment: .leading)
                        ZStack {
                            if like.isEmpty { Text("好きなもの").foregroundColor(Color.gray) }
                            TextField("", text: $like)
                        }
                    }.foregroundColor(Color.black)
                    HStack {
                        Text("嫌いなもの")
                            .frame(width: 120, alignment: .leading)
                        ZStack {
                            if dislike.isEmpty { Text("嫌いなもの").foregroundColor(Color.gray) }
                            TextField("", text: $dislike)
                        }
                    }.foregroundColor(Color.black)
                } //:Section
                .listRowBackground(Color.white)
                //----------- 連絡先 -----------
                Section(header: Text("連絡先")) {
                    HStack {
                        Text("電話番号")
                            .frame(width: 120, alignment: .leading)
                        ZStack {
                            if tel.isEmpty { Text("000-0000-0000").foregroundColor(Color.gray) }
                            TextField("", text: $tel)
                                .keyboardType(.phonePad)
                        }
                    }.foregroundColor(Color.black)
                    HStack {
                        Text("メール")
                            .frame(width: 120, alignment: .leading)
                        ZStack {
                            if mail.isEmpty { Text("xxxxxxxx@xxx.jp").foregroundColor(Color.gray) }
                            TextField("", text: $mail)
                        }
                    }.foregroundColor(Color.black)
                }
                .listRowBackground(Color.white)
                //----------- メモ -----------
                Section(header: Text("追加情報")) {
                    ZStack {
                        if explanation.isEmpty { Text("特徴や最近話したことなどをメモしよう").foregroundColor(Color.gray) }
                        TextField("", text: $explanation).foregroundColor(Color.black)
                    }
                }
                .listRowBackground(Color.white)
                //----------- 登録ボタン -----------
                HStack(alignment: .center) {
                    Spacer()
                    Button(action: {
                        // 入力データをクリア
                        cancelData()
                        self.showNewData = false
                    }){
                        HStack{
                            Image(systemName: "minus.circle.fill")
                            Text("キャンセル")
                                .font(.headline)
                        }.foregroundColor(.red)
                    }
                    Spacer()
                } //:HStack
                .listRowBackground(Color.white)
            } //:Form
            .background(Color.tOrange)
            .navigationBarTitle("情報の追加")
            .navigationBarItems(trailing: Button(action: {
                // 新しいEntityデータを作成する
                addNewData()
                self.showNewData = false
            }){
                Text("追加")
            })
            .frame(width: 375) //375にしておくと、iPhon8でも対応できる
        } //:NavigationView
    } //:body
} //:view


struct NewData_Previews: PreviewProvider {
    static var previews: some View {
        NewData(showNewData: .constant(true))
            .environment(\.managedObjectContext, PersistentController.preview.container.viewContext)
    }
}

