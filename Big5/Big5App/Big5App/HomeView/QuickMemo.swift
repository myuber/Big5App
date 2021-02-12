//
//  QuickMemo.swift
//  Big5App
//
//  Created by がり on 2021/01/31.
//

import SwiftUI

struct QuickMemo: View {    
    @ObservedObject var personalData: PersonalDataEntity
    // 保存処理に必要なコンテキスト
    @Environment(\.managedObjectContext) private var viewContext
    
    let persistentContainer = PersistentController.shared
    
    // モーダルViewを閉じるための変数
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var inputText = ""
    
    //MARK: -Function
    fileprivate func addExplanation() {
        if (personalData.explanation == nil) {
            personalData.explanation = self.inputText
        } else if (personalData.explanation == "") {
            personalData.explanation = self.inputText
        } else {
            personalData.explanation = personalData.explanation! + "\n" + self.inputText
        }
        self.inputText = ""
        saveContext()
    }
    
    fileprivate func cancelExplanation() {
        self.inputText = ""
    }
    
    fileprivate func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error: \(error)")
        }
    }
    
//MARK: -body
    var body: some View {
        VStack {
            Image("image01")
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            
            TextField("この人について情報を追加しよう", text: $inputText, onCommit:  {
                addExplanation()
            })
                .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.leading, 10)
            .padding(.trailing, 10)
            
            HStack {
                
                Button(action: {
                    cancelExplanation()
                }) {
                    Text("キャンセル")
                }
                .padding(.leading, 10)
                Spacer()
                ZStack {
                    Capsule()
                        .fill(Color.gradient)
                        .frame(width:100, height: 40)
                    HStack{
                        Image(systemName: "pencil.circle.fill")
                        Text("追加する").font(.headline)
                    }.foregroundColor(.white)
                }.onTapGesture {
                    addExplanation()
                    self.presentationMode.wrappedValue.dismiss()
                } //:onTapGesture
                .padding(.trailing, 10)
            } //:HStack
        } //:VStack
    } //:body
} //:view


/*
//MARK: -preview
struct QuickMemo_Previews: PreviewProvider {
    static var previews: some View {
        QuickMemo()
    }
}
*/
