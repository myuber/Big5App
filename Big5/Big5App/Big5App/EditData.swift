//
//  EditData.swift
//  Big5App
//
//  Created by がり on 2021/01/23.
//

import SwiftUI

struct EditData: View {
    @ObservedObject var personalData: PersonalDataEntity
    // 保存処理に必要なコンテキスト
    @Environment(\.managedObjectContext) private var viewContext

    
    // Big5Editを表示するSheet判定用の変数
    @State var showBig5EditSheet = false
    
    fileprivate func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error: \(error)")
        }
    }
    
    fileprivate func deleteData() {
        withAnimation {
            viewContext.delete(personalData)
            saveContext()
            
        }
    }
    
    var body: some View {
        Form {
            VStack {
                HStack {
                    Spacer()
                    Image("image01").resizable().frame(width: 100, height: 100)
                    Spacer()
                } //:HStack
            } //:VStack
            //MARK: -Chart
            Section {
                Text("Chart")
                /*
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
                    } //:sheet
                    Spacer()
                } //:HStack
                NavigationLink(destination: big5SlideView(personalData: personalData)){
                        Text("Big5を登録する")
                } //:NavigationLink
                */
                
            } //:Section
            //MARK: -基本情報
            Section {
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
                        Text("男性").tag("男性")
                        Text("女性").tag("女性")
                        Text("その他").tag("その他")
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
            //MARK: -メモ
            Section(header: Text("追加情報")) {
                TextField("最近話したことなどをメモしよう", text: Binding($personalData.explanation, "new explanation"))
                 
            }
           
            //MARK: -登録ボタン
            //----------- 登録ボタン -----------
            HStack(alignment: .center) {
                Spacer()
                Button(action: {
                    self.deleteData()
                }){
                    HStack{
                        Image(systemName: "minus.circle.fill")
                        Text("削除")
                            .font(.headline)
                    }.foregroundColor(.red)
                }
                Spacer()
            } //:HStack
        } //:Form
        .navigationBarTitle("情報の編集")
        .navigationBarItems(trailing: Button(action: {
            self.saveContext()
        }){
            Text("保存")
        })
        .frame(width: 375)
    } //:body
} //:view

struct EditData_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
    }
}
