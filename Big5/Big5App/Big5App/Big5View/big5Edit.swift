//
//  big5Edit.swift
//  Big5App
//
//  Created by がり on 2021/01/24.
//

import SwiftUI
import Charts

struct big5Edit: View {
    @ObservedObject var personalData: PersonalDataEntity
    // 保存処理に必要なコンテキスト
    @Environment(\.managedObjectContext) private var viewContext
    
    @Environment(\.presentationMode) var presentationMode
    
    // 保存ボタンを押すまでpersonalDataの数値を編集したくないため、仮の変数を定義
    @State var EditAgree: Int16
    @State var EditExtra: Int16
    @State var EditOpen: Int16
    @State var EditConscien: Int16
    @State var EditNeuro: Int16
    
    var body: some View {
        VStack {
            ChartView(entries: [
                RadarChartDataEntry(value: Double(EditAgree)),
                RadarChartDataEntry(value: Double(EditExtra)),
                RadarChartDataEntry(value: Double(EditOpen)),
                RadarChartDataEntry(value: Double(EditConscien)),
                RadarChartDataEntry(value: Double(EditNeuro))
            ]).frame(width: 375, height: 375) //375にしておくと、iPhon8でも対応できる

            HStack{
                Stepper(value: $EditAgree, in: -4...4) {
                    Text("協調性")
                }
                Text(String(EditAgree))
            }
            HStack{
                Stepper(value: $EditExtra, in: -4...4) {
                    Text("外向性")
                }
                Text(String(EditExtra))
            }
            HStack{
                Stepper(value: $EditOpen, in: -4...4) {
                    Text("開放性")
                }
                Text(String(EditOpen))
            }
            HStack{
                Stepper(value: $EditConscien, in: -4...4) {
                    Text("誠実性")
                }
                Text(String(EditConscien))
            }
            HStack{
                Stepper(value: $EditNeuro, in: -4...4) {
                    Text("神経症的傾向")
                }
                Text(String(EditNeuro))
            }
            
            Button(action: {
                personalData.big5Agree = EditAgree
                personalData.big5Extra = EditExtra
                personalData.big5Open = EditOpen
                personalData.big5Conscien = EditConscien
                personalData.big5Neuro = EditNeuro
                self.presentationMode.wrappedValue.dismiss()
            }){
                Text("保存")
            }
        }
    }
}

/*
struct big5Edit_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/
