//
//  EditData.swift
//  Big5
//
//  Created by がり on 2020/12/29.
//  Copyright © 2020 がり. All rights reserved.
//

import SwiftUI
import Charts

struct EditData: View {
    @ObservedObject var personalData: PersonalInfoEntity
    // 保存処理に必要なコンテキスト
    @Environment(\.managedObjectContext) var viewContext
    
    // モーダルViewを閉じるための変数
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // Big5Editを表示するSheet判定用の変数
    @State var showBig5EditSheet = false
    
    // 削除処理
    fileprivate func delete() {
        viewContext.delete(personalData)
        save()
    }
    
    // 保存処理
    fileprivate func save() {
        do {
            try self.viewContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
//MARK: -body
    var body: some View {
        NavigationView {
            Form {
//MARK: -chart
                VStack {
                    HStack {
                        Spacer()
                        Image("image01").resizable().frame(width: 100, height: 100)
                        Spacer()
                    }
                }
                
                Section {
                    HStack {
                        Spacer()
                        ChartView(entries: [
                            RadarChartDataEntry(value: Double(personalData.big5Agree)),
                            RadarChartDataEntry(value: Double(personalData.big5Extra)),
                            RadarChartDataEntry(value: Double(personalData.big5Open)),
                            RadarChartDataEntry(value: Double(personalData.big5Conscien)),
                            RadarChartDataEntry(value: Double(personalData.big5Neuro))
                        ])
                            .frame(width: 250, height: 250)
                            .onTapGesture {
                                self.showBig5EditSheet = true
                            }.sheet(isPresented: $showBig5EditSheet) {
                                big5Edit(personalData: self.personalData)
                                .environment(\.managedObjectContext, self.viewContext)
                            }
                        Spacer()
                    } //:HStack
                    NavigationLink(destination: big5SlideView(personalData: personalData)){
                        Spacer()
                        ZStack {
                            Capsule()
                                .fill(Color.diagonalGradient)
                                .frame(width:200, height: 40)
                            Text("Big5を登録する")
                                .font(.headline)
                                .foregroundColor(.white)
                        } //:ZStack
                        Spacer()
                    } //:NavigationLink
                } //:Section
                    
               
//MARK: -基本情報
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
                } //:Section
//MARK: -連絡先
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
                } //:Section
//MARK: -メモ
                Section(header: Text("追加情報")) {
                    TextField("最近話したことなどをメモしよう", text: Binding($personalData.explanation, "new explanation"))
                } //:Section
//MARK: -登録ボタン
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
                    } //:Button
                    Spacer()
                } //:HsStack
//MARK: -保存ボタン
            } //:From
            .navigationBarTitle("情報の編集")
            .navigationBarItems(trailing: Button(action: {
                self.save()
                self.presentationMode.wrappedValue.dismiss()
            }){
                Text("保存")
            })
                .frame(width: UIScreen.screenWidth)
            
        } //Navigationview
    } //:body
} //:view

struct EditData_Previews: PreviewProvider {
    static let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    
    static var previews: some View {
        let newData = PersonalInfoEntity(context: context)
        return EditData(personalData: newData)
            .environment(\.managedObjectContext, context)
    }
}

