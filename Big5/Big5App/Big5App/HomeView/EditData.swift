//
//  EditData.swift
//  Big5App
//
//  Created by がり on 2021/01/23.
//

import SwiftUI
import Charts

struct EditData: View {
    @ObservedObject var personalData: PersonalDataEntity
    // 保存処理に必要なコンテキスト
    @Environment(\.managedObjectContext) private var viewContext
    
    let persistentContainer = PersistentController.shared

    // Viewを閉じるための変数
    @Environment(\.presentationMode) var presentationMode
    
    // big5SlideViewを表示/非表示を切り替える変数
    @Binding var showbig5SlideView: Bool
    @Binding var DetailFlg: Bool
    
    
    // Big5Editを表示するSheet判定用の変数
    @State var showBig5EditSheet = false
//MARK: -仮データ
    @State private var newName: String = ""
    @State private var newKana: String = ""
    @State private var newNickname: String = ""
    @State private var newBirthday: Date = Date()
    @State private var newFrom: String = ""
    @State private var newJob: String = ""
    @State private var newLike: String = ""
    @State private var newDislike: String = ""
    @State private var newTel: String = ""
    @State private var newMail: String = ""
    @State private var newExplanetion: String = ""
    
//MARK: -func
    
    
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
    
//MARK: -body
    var body: some View {
        
        // Formの背景設定を一度クリアにする
        UITableView.appearance().backgroundColor = .clear
        
        return VStack{
            Form {
            VStack {
                IconView(personalData: self.personalData)
                    .environment(\.managedObjectContext, self.viewContext)
            } //:VStack
            //MARK: -Chart
            Section {
                // 1度もBig5診断をしていない場合は、notの値が0なので分岐
                // 診断前の場合は診断ボタンを表示、診断後はChartViewを表示
                if personalData.big5NotNeuro != 0 {
                    HStack {
                        Spacer()
                        VStack {
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
                                big5Edit(personalData: personalData,
                                         EditAgree: personalData.big5Agree,
                                         EditExtra: personalData.big5Extra,
                                         EditOpen: personalData.big5Open,
                                         EditConscien: personalData.big5Conscien,
                                         EditNeuro: personalData.big5Neuro)
                                    .environment(\.managedObjectContext,
                                        persistentContainer.container.viewContext)
                            } //:sheet

                            Text("グラフをタップして数値を変更")
                        } //:VStack
                        Spacer()
                    } //:HStack
                
                } else {
                    
                    HStack{
                        Spacer()
                        ZStack {
                            Capsule()
                                .fill(Color.diagonalGradient)
                                .frame(width:200, height: 40)
                            Text("Big5性格診断をする")
                                .font(.headline)
                                .foregroundColor(.white)
                        } //:ZStack
                            .onTapGesture {
                                // Big5を登録するときは,前データが残ってしまうのでデータをリセットする
                                personalData.big5Agree = 0
                                personalData.big5Extra = 0
                                personalData.big5Open = 0
                                personalData.big5Conscien = 0
                                personalData.big5Neuro = 0
                                personalData.big5NotAgree = 0
                                personalData.big5NotExtra = 0
                                personalData.big5NotOpen = 0
                                personalData.big5NotConscien = 0
                                personalData.big5NotNeuro = 0
                                self.showbig5SlideView = true
                        } //:onTapGesture
                        Spacer()
                    } //:HStack
                } //: if~else
                
            } //:Section
            //MARK: -基本情報
            Section {
                HStack {
                    Text("名前")
                        .frame(width: 120, alignment: .leading)
                    TextField("お名前", text: $newName)
                }
                HStack {
                    Text("フリガナ")
                        .frame(width: 120, alignment: .leading)
                    TextField("フリガナ", text: $newKana)
                }
                
                HStack {
                    Text("ニックネーム")
                        .frame(width: 120, alignment: .leading)
                    TextField("ニックネーム", text: $newNickname)
                }
                
                DatePicker(selection: $newBirthday,
                           displayedComponents: .date,
                           label: {Text("誕生日")}
                )
                
                HStack {
                    Text("出身地")
                        .frame(width: 120, alignment: .leading)
                    TextField("〇〇県〇〇市", text: $newFrom)
                }
                HStack {
                    Text("職業")
                        .frame(width: 120, alignment: .leading)
                    TextField("会社員", text: $newJob)
                }
                HStack {
                    Text("好きなもの")
                        .frame(width: 120, alignment: .leading)
                    TextField("好きなもの", text: $newLike)
                }
                HStack {
                    Text("嫌いなもの")
                        .frame(width: 120, alignment: .leading)
                    TextField("嫌いなもの", text: $newDislike)
                }
            } //:Section
            //MARK: -連絡先
            //----------- 連絡先 -----------
            
             Section(header: Text("連絡先")) {
                HStack {
                    Text("電話番号")
                        .frame(width: 120, alignment: .leading)
                    TextField("000-0000-0000", text: $newTel)
                        .keyboardType(.phonePad)
                }
                HStack {
                    Text("メール")
                        .frame(width: 120, alignment: .leading)
                    TextField("xxxxxxxx@xxx.jp", text: $newMail)
                }
            }
            //MARK: -メモ
            Section(header: Text("追加情報")) {
                TextField("特徴や最近話したことなどをメモしよう", text: $newExplanetion)
            }
           
            //MARK: -登録ボタン
            //----------- 登録ボタン -----------
            HStack(alignment: .center) {
                Spacer()
                ZStack {
                    Capsule()
                        .fill(Color.EditGradient)
                        .frame(width:100, height: 40)
                    HStack{
                        Image(systemName: "pencil.circle.fill")
                        Text("保存").font(.headline)
                    }.foregroundColor(.white)
                }.onTapGesture {
                    personalData.name = self.newName
                    personalData.kana = self.newKana
                    personalData.nickname = self.newNickname
                    personalData.birthday = self.newBirthday
                    personalData.from = self.newFrom
                    personalData.job = self.newJob
                    personalData.like = self.newLike
                    personalData.dislike = self.newDislike
                    personalData.tel = self.newTel
                    personalData.mail = self.newMail
                    personalData.explanation = self.newExplanetion
                    
                    self.saveContext()
                    self.presentationMode.wrappedValue.dismiss()
                } //:onTapGesture
                
                Spacer()
                
                // 削除ボタン
                ZStack {
                    Capsule()
                        .fill(Color.DeleteGradient)
                        .frame(width:100, height: 40)
                    HStack{
                        Image(systemName: "minus.circle.fill")
                        Text("削除").font(.headline)
                    }.foregroundColor(.white)
                }.onTapGesture {
                   // self.presentationMode.wrappedValue.dismiss()
                    self.DetailFlg = false
                    self.deleteData()
                } //:onTapGesture
                
                Spacer()
            } //:HStack
        } //:Form
        .background(Color.tOrange)
        
        
        //MARK: -big5SlideView
        if showbig5SlideView {
            big5SlideView(personalData: personalData, showbig5SlideView: $showbig5SlideView)
        } //:if
        }
        .onAppear{
            if personalData.name != nil {
                self.newName = personalData.name!
            }
            if personalData.kana != nil {
                self.newKana = personalData.kana!
            }
            if personalData.nickname != nil {
                self.newNickname = personalData.nickname!
            }
            if personalData.birthday != nil {
                self.newBirthday = personalData.birthday!
            }
            if personalData.from != nil {
                self.newFrom = personalData.from!
            }
            if personalData.job != nil {
                self.newJob = personalData.job!
            }
            if personalData.like != nil {
                self.newLike = personalData.like!
            }
            if personalData.dislike != nil {
                self.newDislike = personalData.dislike!
            }
            if personalData.tel != nil {
                self.newTel = personalData.tel!
            }
            if personalData.mail != nil {
                self.newMail = personalData.mail!
            }
            if personalData.explanation != nil {
                self.newExplanetion = personalData.explanation!
            }
        }
        
    } //:body
} //:view


struct EditData_Previews: PreviewProvider {
        static var previews: some View {
             ContentView(showNewData: .constant(false))
                 .environment(\.managedObjectContext, PersistentController.preview.container.viewContext)
        }
}


