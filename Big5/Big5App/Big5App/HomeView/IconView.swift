//
//  IconView.swift
//  Big5App
//
//  Created by がり on 2021/02/09.
//

import SwiftUI

struct IconView: View {
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    
    var body: some View {
        HStack {
            Spacer()
            if selectedImage != nil {
                Image(uiImage: selectedImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
            } else {
                Image(systemName: "snow")
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
            ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
        }
        
    } //:body
} //:view

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        IconView()
    }
}
