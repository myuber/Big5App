//
//  ImagePickerView.swift
//  Big5App
//
//  Created by がり on 2021/02/09.
//

import UIKit
import SwiftUI


// UIViewControllerRepresentableプロトコルを確認する構造体を定義
// UIViewControllerRepresentableはSwiftUIでUIKitを使用するのに役立つ
struct ImagePickerView: UIViewControllerRepresentable {
    @ObservedObject var personalData: PersonalDataEntity
    
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    
    // 画像がライブラリから取得されたかカメラから取得されたかを定義する変数
    var sourceType: UIImagePickerController.SourceType
    
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = self.sourceType
        imagePicker.delegate = context.coordinator // デリゲートを確認
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    // この構造体とCoodinatorクラスを連携する関数
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self, personalData: personalData)
    }
}


