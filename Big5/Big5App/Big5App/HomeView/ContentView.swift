//
//  ContentView.swift
//  Big5App
//
//  Created by がり on 2021/01/21.
//

import SwiftUI



struct ContentView: View {
    // NewDataの表示/非表示を判定する変数
    @Binding var showNewData: Bool
    
    // 保存処理に必要なコンテキスト
    @Environment(\.managedObjectContext) private var viewContext
    
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \PersonalDataEntity.kana,
             ascending: true)],
         animation: .default
    )
    private var personalData: FetchedResults<PersonalDataEntity>
    
    
    // NavigationLinkのisActiveに使用するフラグ
    @State var DetailFlg: Bool = false
    @State var QuickFlg: Bool = false
    
    @State var showQuickMemo: Bool = false
    
    // 何番目のデータを開くか番号を格納する変数
    @State var naviNum:Int = 0
        
//MARK: -body
    var body: some View {
        NavigationView {
            VStack {
                List {
                    // Entityデータの数だけループ処理
                    ForEach(0..<personalData.count) { dataNum in
                        HStack {
                            // 名前をタップするとDetailDataを開く
                            Text(personalData[dataNum].name ?? "")
                                .onTapGesture {
                                    self.DetailFlg = true
                                    self.naviNum = dataNum
                                }
                            
                            // タップするとQuickMemoを開く
                            Text("メモを追加")
                                .onTapGesture {
                                    self.QuickFlg = true
                                    self.naviNum = dataNum
                                }
                        } //:HStack
                            // 長押ししたら開く
                            .onLongPressGesture {
                                self.QuickFlg = true
                                self.naviNum = dataNum
                            } //:onLongPressGesture
                        
                    } //:ForEach
                } //:List
//MARK: -showNewData
                // NewDataを開くアイコン
                HStack{
                    Spacer()
                    Button(action: {
                        self.showNewData = true
                    }, label: {
                        Image(systemName: "person.crop.circle.badge.plus")
                            .resizable()
                            .scaledToFill()             //アスペクト比を維持してリサイズする
                            .frame(width: 50, height: 50)
                    })
                    
                    Spacer().frame(width: 30)
                } //:HStack
                
//MARK: -NavigationLink
                NavigationLink(destination: DetailData(personalData: personalData[naviNum]), isActive: $DetailFlg) {
                    EmptyView()
                }
                NavigationLink(destination: QuickMemo(personalData: personalData[naviNum]), isActive: $QuickFlg) {
                    EmptyView()
                }
                
            } //:VStack
        } //:NavigationView
        .navigationBarTitle("一覧表示")
    } //:body
    
    
    
//MARK: -function
    
    // 保存処理
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error: \(error)")
        }
    } //:func
    
    // 更新処理
    private func updateData(_ data: FetchedResults<PersonalDataEntity>.Element) {
        withAnimation {
            data.name = "Updated"
            saveContext()
        }
    } //:func
    
    // 削除処理
    private func deleteData(offsets: IndexSet) {
        withAnimation {
            offsets.map { personalData[$0] }.forEach(viewContext.delete)
            saveContext()
        }
    } //:func
    
    // 追加処理
    private func addData() {
        withAnimation {
            let newData = PersonalDataEntity(context: viewContext)
            newData.name = "New Data \(Date())"
            newData.id = "\(Date())"
            saveContext()
        }
    } //:func
    
} //:view


//MARK: -preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView(showNewData: .constant(false))
            .environment(\.managedObjectContext, PersistentController.preview.container.viewContext)
    }
}


