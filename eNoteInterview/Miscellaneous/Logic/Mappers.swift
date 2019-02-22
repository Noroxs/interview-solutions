//
//  Mappers.swift
//  eNoteInterview
//
//  Created by Ramson, Thomas on 2/22/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import UIKit

protocol NumberMapping {

  func mapToValueEntities(sortedNumbers: [(key: Int, value: Int)]) -> [ValueEntity<Int>]
    
}

struct StaticNumberMapper: NumberMapping  {
    
    let staticMappedNumbers: [ValueEntity<Int>]
    
    init(staticMappedNumbers: [ValueEntity<Int>]) {
        
        self.staticMappedNumbers = staticMappedNumbers
    }
    
    func mapToValueEntities(sortedNumbers: [(key: Int, value: Int)]) -> [ValueEntity<Int>] {
        
        return staticMappedNumbers
    }
    
}

struct NumberMapper: NumberMapping {

    func mapToValueEntities(sortedNumbers: [(key: Int, value: Int)]) -> [ValueEntity<Int>] {

        return sortedNumbers.map { ValueEntity($0, amount: $1) }
    }

}

