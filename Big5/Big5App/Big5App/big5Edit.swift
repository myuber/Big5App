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
    
    var body: some View {
        VStack {
            ChartView(entries: [
                RadarChartDataEntry(value: Double(personalData.big5Agree)),
                RadarChartDataEntry(value: Double(personalData.big5Extra)),
                RadarChartDataEntry(value: Double(personalData.big5Open)),
                RadarChartDataEntry(value: Double(personalData.big5Conscien)),
                RadarChartDataEntry(value: Double(personalData.big5Neuro))
            ]).frame(width: 375, height: 375) //375にしておくと、iPhon8でも対応できる

            HStack{
                Stepper(value: $personalData.big5Agree, in: -4...4) {
                    Text("協調性")
                }
                Text(String(personalData.big5Agree))
            }
            HStack{
                Stepper(value: $personalData.big5Extra, in: -4...4) {
                    Text("外向性")
                }
                Text(String(personalData.big5Extra))
            }
            HStack{
                Stepper(value: $personalData.big5Open, in: -4...4) {
                    Text("開放性")
                }
                Text(String(personalData.big5Open))
            }
            HStack{
                Stepper(value: $personalData.big5Conscien, in: -4...4) {
                    Text("誠実性")
                }
                Text(String(personalData.big5Conscien))
            }
            HStack{
                Stepper(value: $personalData.big5Neuro, in: -4...4) {
                    Text("神経症的傾向")
                }
                Text(String(personalData.big5Neuro))
            }
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }){
                Text("保存")
            }
        }
    }
}

struct big5Edit_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
