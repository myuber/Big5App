//
//  DetailData.swift
//  Big5
//
//  Created by がり on 2021/01/11.
//  Copyright © 2021 がり. All rights reserved.
//

import SwiftUI
import Charts

struct DetailData: View {
    @ObservedObject var personalData: PersonalInfoEntity
    // 保存処理に必要なコンテキスト
    @Environment(\.managedObjectContext) var viewContext
    
    // Big5Editを表示するSheet判定用の変数
    @State var showEditSheet = false
    
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
        
        // 現在日時を dt に代入
        let dt = personalData.birthday
        // DateFormatter のインスタンスを作成
        let formatter: DateFormatter = DateFormatter()
        // ロケールを日本（日本語）に設定
        formatter.locale = Locale(identifier: "ja_JP")
        
        // 文字列に変換して表示
        let strBirthday = formatter.string(from: dt ?? Date())

        
        return Form {
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
                    Spacer()
                } //:HStack
            } //:Section
                
           
//MARK: -基本情報
            Section(header: Text("基本情報")){
                HStack {
                    Text("名前")
                        .frame(width: 120, alignment: .leading)
                    Text(personalData.name ?? "no title")
                }
                HStack {
                    Text("フリガナ")
                        .frame(width: 120, alignment: .leading)
                    Text(personalData.kana ?? "no title")
                }
                HStack {
                    Text("ニックネーム")
                        .frame(width: 120, alignment: .leading)
                    Text(personalData.nickname ?? "no title")
                }
                HStack {
                    Text("性別")
                        .frame(width: 120, alignment: .leading)
                    Text(String(personalData.sex))
                }

                HStack {
                    Text("誕生日")
                        .frame(width: 120, alignment: .leading)
                    Text(strBirthday)
                }
                
                HStack {
                    Text("出身地")
                        .frame(width: 120, alignment: .leading)
                    Text(personalData.from ?? "no title")
                }
                HStack {
                    Text("職業")
                        .frame(width: 120, alignment: .leading)
                    Text(personalData.job ?? "no title")
                }
                HStack {
                    Text("好きなもの")
                        .frame(width: 120, alignment: .leading)
                    Text(personalData.like ?? "no title")
                }
                HStack {
                    Text("嫌いなもの")
                        .frame(width: 120, alignment: .leading)
                    Text(personalData.dislike ?? "no title")
                }
            } //:Section
//MARK: -連絡先
            Section(header: Text("連絡先")) {
                HStack {
                    Text("電話番号")
                        .frame(width: 120, alignment: .leading)
                    Text(personalData.tel ?? "no title")
                }
                HStack {
                    Text("メール")
                        .frame(width: 120, alignment: .leading)
                    Text(personalData.mail ?? "no title")
                }
            } //:Section
//MARK: -メモ
            Section(header: Text("追加情報")) {
                Text(personalData.explanation ?? "no title")
            } //:Section
//MARK: -操作ボタン
            HStack(alignment: .center) {
                Spacer()
                // 編集ボタン
                ZStack {
                    Capsule()
                        .fill(Color.EditGradient)
                        .frame(width:100, height: 40)
                    HStack{
                        Image(systemName: "pencil.circle.fill")
                        Text("編集").font(.headline)
                    }.foregroundColor(.white)
                }.onTapGesture {
                    self.showEditSheet = true
                }.sheet(isPresented: $showEditSheet) {
                    EditData(personalData: self.personalData)
                    .environment(\.managedObjectContext, self.viewContext)
                } //:onTapGesture
                
                Spacer().frame(width: 30)
                
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
                    self.delete()
                } //:onTapGesture
                Spacer()
            } //:HsStack
//MARK: -保存ボタン
        } //:From
            .frame(width: UIScreen.screenWidth) //375にしておくと、iPhon8でも対応できる
    } //:body
} //:view


struct DetailData_Previews: PreviewProvider {
    static let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    
    static var previews: some View {
        let newData = PersonalInfoEntity(context: context)
        return DetailData(personalData: newData)
            .environment(\.managedObjectContext, context)
    }
}
