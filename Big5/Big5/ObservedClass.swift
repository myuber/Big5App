//
//  ObservedClass.swift
//  Big5
//
//  Created by がり on 2021/01/05.
//  Copyright © 2021 がり. All rights reserved.
//

import SwiftUI

class ObservedClass: ObservableObject {
     @Published var quesList = ["質問1", "質問2", "質問3", "質問4", "質問5", "質問6", "質問7", "質問8", "質問9", "質問10"]
     @Published var quesNum = 0
}
