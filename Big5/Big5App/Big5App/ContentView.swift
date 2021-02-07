//
//  ContentView.swift
//  Big5App
//
//  Created by がり on 2021/01/21.
//

import SwiftUI



struct ContentView: View {
    @Binding var showNewData: Bool
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \PersonalDataEntity.kana,
             ascending: true)],
         animation: .default
    )
    private var personalData: FetchedResults<PersonalDataEntity>
    
    
    @State var naviData: PersonalDataEntity
        
    // NavigationLinkのisActiveに使用するフラグ
    @State var DetailFlg: Bool = false
    @State var QuickFlg: Bool = false
    
    @State var showQuickMemo: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(personalData) { data in
                        HStack {
                        Button(action: {
                            self.DetailFlg = true
                            self.naviData = data
                        }) {
                            Text(data.name ?? "")
                        }
                        Spacer()
                        Button(action: {
                            self.QuickFlg = true
                            self.naviData = data
                        }) {
                            Text("メモを追加")
                        }
                        } //:HStack
                        
                    } //:ForEach
                } //:List
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
                
                NavigationLink(destination: DetailData(personalData: naviData), isActive: $DetailFlg) {
                    EmptyView()
                }
                NavigationLink(destination: QuickMemo(personalData: naviData), isActive: $QuickFlg) {
                    EmptyView()
                }
                
            } //:VStack
        } //:NavigationView
        .navigationBarTitle("一覧表示")
    } //:body
    
    
    
    //MARK: -function
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error: \(error)")
        }
    } //:func
    
    private func updateData(_ data: FetchedResults<PersonalDataEntity>.Element) {
        withAnimation {
            data.name = "Updated"
            saveContext()
        }
    } //:func
    
    private func deleteData(offsets: IndexSet) {
        withAnimation {
            offsets.map { personalData[$0] }.forEach(viewContext.delete)
            saveContext()
            
        }
    } //:func
    
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
            .environment(\.managedObjectContext, PersistentController.shared.container.viewContext)
    }
}


