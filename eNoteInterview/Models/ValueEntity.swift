//
//  ValueEntity.swift
//  eNoteInterview
//
//  Created by Ramson, Thomas on 2/21/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import UIKit

struct ValueEntity<T> {
    
    var value: T
    var amount: Int = 0
    
    init(_ value: T) {
        
        self.value = value
    }
    
}

extension ValueEntity where T == Int {
    
    var valueString: String { return String(value) }
    var amountString: String { return String(amount) }
}
