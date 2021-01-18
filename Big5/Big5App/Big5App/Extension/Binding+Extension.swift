//
//  Binding+Extension.swift
//  Big5
//
//  Created by がり on 2020/12/31.
//  Copyright © 2020 がり. All rights reserved.
//
import SwiftUI


extension Binding {
    // 与えられたオブジェクトがnilかnilじゃないかで、True/Falseに変換するイニシャライザ
    // イニシャライザは任意のBinding<T?>を取得して、nilかnilじゃないかでBool型のBindingに変換している
    // source.wrappedValueには実際に渡されたoptionalな値が入っている
    init<T>(isNotNil source: Binding<T?>, defaultValue: T) where Value == Bool {
        // nilだったらFalse、nilじゃなかったらTrue
        self.init(get: { source.wrappedValue != nil },
                  set: { source.wrappedValue = $0 ? defaultValue : nil })
    }
    
    // optional型のオブジェクトはoptional型じゃないものとして扱うイニシャライザ
    init(_ source: Binding<Value?>, _ defaultValue: Value) {
        self.init(get: {
            /*
             source.wrappedValueはoptional型なのでnilになる可能性がある、
             nilの場合はdefaultValueを格納して、
            */
            if source.wrappedValue == nil {
                source.wrappedValue = defaultValue
            }
            return source.wrappedValue ?? defaultValue
            // 受け取るときは元々optional型でないものをsource.wrappedValueに入れる
        },set:{
            source.wrappedValue = $0
        })
    }
}
