//
//  DataList.swift
//  Big5
//
//  Created by がり on 2020/12/29.
//  Copyright © 2020 がり. All rights reserved.
//

import SwiftUI
import CoreData

struct DataList: View {
    
    // CoreDataのデータを取得するアノテーション
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PersonalInfoEntity.name,
            ascending: true)],
        animation: .default
    )
        
    var personalDataList: FetchedResults<PersonalInfoEntity>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(personalDataList) { data in
                    HStack {
                        Text(data.name ?? "未設定")
                        Text(data.tel ?? "未設定")
                        
                    }
                }
            }
        }.navigationBarTitle("一覧表示")
    }
}

struct PersonalDataList_Previews: PreviewProvider {
    static let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    static let context = container.viewContext
    
    static var previews: some View {
        // テストデータの全削除
        let request = NSBatchDeleteRequest(
            fetchRequest: NSFetchRequest(entityName: "PersonalInfoEntity"))
        try! container.persistentStoreCoordinator.execute(request, with: context)
        
        // テストデータの追加
        PersonalInfoEntity.create(in: context,
                                  name: "田中太郎",
                                   kana: "たなかたろう",
                                   nickname: "たなやん",
                                   sex: 2,
                                   birthday: Date(),
                                   from: "沖縄県",
                                   job: "",
                                   like: "寿司",
                                   dislike: "虫",
                                   tel: "000-0000-0000",
                                   mail: "aaaaa@tttt.com",
                                   explanation: "")
        
        PersonalInfoEntity.create(in: context,
                                    name: "長田大輔",
                                     kana: "おさだだいすけ",
                                     nickname: "おっさ",
                                     sex: 0,
                                     birthday: Date(),
                                     from: "静岡県",
                                     job: "",
                                     like: "寿司",
                                     dislike: "虫",
                                     tel: "111-1111-1111",
                                     mail: "ossa@xxxxx.com",
                                     explanation: "おっさです")

                                   
        
        return DataList()
            .environment(\.managedObjectContext, context)
    }
}
