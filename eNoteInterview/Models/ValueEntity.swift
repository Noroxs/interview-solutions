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
    
    init(_ value: T, amount: Int = 0) {
        
        self.value = value
        self.amount = amount
    }
    
}

extension ValueEntity: CustomStringConvertible {
    
    var description: String { return "\(value) - \(amount)" }
    
}

extension ValueEntity: Equatable where T == Int {
    
    static func == (lhs: ValueEntity<T>, rhs: ValueEntity<T>) -> Bool {
        
        return lhs.value == rhs.value && lhs.amount == rhs.amount
    }
    
}

extension ValueEntity where T == Int {
    
    var valueString: String { return String(value) }
    var amountString: String { return String(amount) }
}
