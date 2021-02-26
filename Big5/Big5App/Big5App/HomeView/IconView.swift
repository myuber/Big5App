//
//  IconView.swift
//  Big5App
//
//  Created by がり on 2021/02/09.
//

import SwiftUI

struct IconView: View {
    @ObservedObject var personalData: PersonalDataEntity
    // 保存処理に必要なコンテキスト
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    
    var body: some View {
        HStack {
            Spacer()
            if personalData.icon != nil {
                let image = UIImage(data: personalData.icon!)
                Image(uiImage: image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
            } else {
                Image(systemName: "person")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
            }
            Spacer()
        } //:HStack
        .onTapGesture{
            self.sourceType = .camera
            self.isImagePickerDisplay.toggle()
        }
        .sheet(isPresented: self.$isImagePickerDisplay) {
            ImagePickerView(personalData: self.personalData, selectedImage: self.$selectedImage, sourceType: self.sourceType)
        }
        
    } //:body
} //:view

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(showNewData: .constant(false))
            .environment(\.managedObjectContext, PersistentController.preview.container.viewContext)
    }
}
