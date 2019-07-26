//
//  Mappers.swift
//  eNoteInterview
//
//  Created by Ramson, Thomas on 2/22/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import UIKit

protocol Mapping {

  func mapToValueEntities(sortedNumbers: [(key: Int, value: Int)]) -> [ValueEntity<Int>]
    
}

extension Mapping {
    
    func mapToValueEntities(sortedNumbers: [(key: Int, value: Int)]) -> [ValueEntity<Int>] {
        
        return sortedNumbers.map { ValueEntity($0, amount: $1) }
    }
    
}

struct StaticMapper: Mapping  {
    
    let staticMappedNumbers: [ValueEntity<Int>]
    
    init(staticMappedNumbers: [ValueEntity<Int>]) {
        
        self.staticMappedNumbers = staticMappedNumbers
    }
    
    func mapToValueEntities(sortedNumbers: [(key: Int, value: Int)]) -> [ValueEntity<Int>] {
        
        return staticMappedNumbers
    }
    
}

struct Mapper: Mapping { }
