//
//  Coodinator.swift
//  Big5App
//
//  Created by がり on 2021/02/09.
//

import UIKit
import CoreData
import SwiftUI

// カメラからキャプチャした画像データまたはフォトライブラリで選択した画像データを取得するために使用するコーディネータクラスを作成
// NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegateを拡張している
class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: ImagePickerView
    
    // 保存処理に必要なコンテキスト
    @Environment(\.managedObjectContext) private var viewContext
    
    init(picker: ImagePickerView) {
        self.picker = picker
    }
    
    // このメソッドはUIImagePickerControllerDelegateから来ている
    // ユーザーがカメラを使用して写真をキャプチャしたとき、またはユーザーがフォトライブラリから画像を選択したときにトリガーされる
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // info [.originalImage]から画像を取得し、その画像をUIImageオブジェクトに変換
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.selectedImage = selectedImage
        
        // 画像をCoreDataへ保存
        let personalData = PersonalDataEntity(context: viewContext)
        let imageData = UIImage.pngData(selectedImage)
        personalData.icon = imageData()
                
        self.picker.isPresented.wrappedValue.dismiss()
    }
}
