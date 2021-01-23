//
//  ContentView.swift
//  Big5App
//
//  Created by がり on 2021/01/21.
//

import SwiftUI



struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \PersonalDataEntity.name,
             ascending: true)],
         animation: .default
    )
    
    private var personalData: FetchedResults<PersonalDataEntity>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(personalData) { data in
                    NavigationLink(destination: EditData(personalData: data)) {
                        HStack {
                            Text(data.name ?? "未設定")
                            Text(data.tel ?? "未設定")
                        } //:HStack
                    } //:NavigationLink
                } //:ForEach
                .onDelete(perform: deleteData)
            } //:List
            .navigationTitle("PersonalData")
            .navigationBarItems(trailing: Button("追加"){
                addData()
            })
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error: \(error)")
        }
    }
    
    private func updateData(_ data: FetchedResults<PersonalDataEntity>.Element) {
        withAnimation {
            data.name = "Updated"
            saveContext()
        }
    }
    
    
    private func deleteData(offsets: IndexSet) {
        withAnimation {
            offsets.map { personalData[$0] }.forEach(viewContext.delete)
            saveContext()
            
        }
    }
    
    private func addData() {
        withAnimation {
            let newData = PersonalDataEntity(context: viewContext)
            newData.name = "New Data \(Date())"
            newData.id = "\(Date())"
            
            saveContext()
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
