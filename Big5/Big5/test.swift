//
//  test.swift
//  Big5
//
//  Created by がり on 2021/01/10.
//  Copyright © 2021 がり. All rights reserved.
//

import SwiftUI

struct test: View {
    @EnvironmentObject var observedClass: ObservedClass
    
    var body: some View {
        
        ForEach(ObservedClass.big5Category.allCases, id: \.self) { (category) in
            Text(category.Big5Question())
        }
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
