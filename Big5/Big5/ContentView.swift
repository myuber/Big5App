//
//  ContentView.swift
//  Big5
//
//  Created by がり on 2020/12/24.
//  Copyright © 2020 がり. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: PersonalDataInput()) {
                        Text("インプット")
                }
                NavigationLink(destination: DataList()) {
                        Text("一覧")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
