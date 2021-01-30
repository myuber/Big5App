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
    
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(personalData) { data in
                        NavigationLink(destination: DetailData(personalData: data)) {
                            HStack {
                                Text(data.name ?? "未設定")
                                Text(data.tel ?? "未設定")
                            } //:HStack
                        } //:NavigationLink
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

