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
            ZStack {
                Color.tOrange
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack {
                    VStack {
                        HStack {
                            Spacer().frame(width: 20)
                            Text("ひとメモ")
                                .font(.largeTitle)
                                .foregroundColor(.tOrange)
                            Spacer()
                        }.padding(.top, 20)
                        
                        ScrollView {
                            // Entityデータの数だけループ処理
                            ForEach(0..<personalData.count, id: \.self) { dataNum in
                                HStack {
                                    Group {
                                        // iconが登録されていなければpersonを表示
                                        if personalData[dataNum].icon != nil {
                                            let image = UIImage(data: personalData[dataNum].icon!)
                                            Image(uiImage: image!)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .clipShape(Circle())
                                                .frame(width: 25, height: 25)
                                                
                                        } else {
                                            Image(systemName: "person")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .clipShape(Circle())
                                                .frame(width: 25, height: 25)
                                        }
                                        
                                        // 名前をタップするとDetailDataを開く
                                        Text(personalData[dataNum].name ?? "no name")
                                            .frame(width: 100)
                                            .padding(.leading, 10.0)
                                    } //:Group
                                        .padding(.leading, 5.0)
                                        .onTapGesture {
                                            self.DetailFlg = true
                                            self.naviNum = dataNum
                                        }
                                        
                                    Spacer()
                                    // タップするとQuickMemoを開く
                                    Image(systemName: "plus")
                                        .foregroundColor(Color.gray)
                                        .padding(.trailing, 10.0)
                                        .onTapGesture {
                                            self.QuickFlg = true
                                            self.naviNum = dataNum
                                        }
                                    Spacer().frame(width: 10)
                                }
                                .padding(.vertical, 5.0) //:HStack
                            
                                    // 長押ししたら開く
                                    .onLongPressGesture {
                                        self.QuickFlg = true
                                        self.naviNum = dataNum
                                    } //:onLongPressGesture
                                
                            } //:ForEach
                            .padding(.top, 10)
                            
                        } //:ScrollView
                    } //:VStack
                    .padding(.horizontal, 10.0)
                    .background(Color.white)
                    .cornerRadius(30)
                    .padding(.all, 10.0)
                    .frame(height: UIScreen.screenHeight / 2)
                    
                    
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
                                .foregroundColor(.white)
                        })
                        
                        Spacer().frame(width: 30)
                    } //:HStack
                    .padding(.top, 10)
                    
    //MARK: -NavigationLink
                    if personalData.count > 0 {
                        NavigationLink(destination: DetailData(personalData: personalData[naviNum]), isActive: $DetailFlg) {
                            EmptyView()
                        }
                        NavigationLink(destination: QuickMemo(personalData: personalData[naviNum]), isActive: $QuickFlg) {
                            EmptyView()
                        }
                    } else {
                        Text("no Data")
                    }
                    
                }
                .padding(.horizontal, 4.0) //:VStack
            } //:ZStack
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


