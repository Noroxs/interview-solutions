//
//  Sorters.swift
//  eNoteInterview
//
//  Created by Ramson, Thomas on 2/22/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import UIKit

protocol NumberSorting {
    
    func sortNumbers(dictionary: [Int: Int]) -> [(key: Int, value: Int)]
    
}

struct StaticNumberSorter: NumberSorting  {
    
    let staticSortedNumbers: [(key: Int, value: Int)]
    
    init(staticSortedNumbers: [(key: Int, value: Int)]) {
        
        self.staticSortedNumbers = staticSortedNumbers
    }
    
    func sortNumbers(dictionary: [Int: Int]) -> [(key: Int, value: Int)] {
        
        return staticSortedNumbers
    }
    
}

struct NumberSorter: NumberSorting {
    
    func sortNumbers(dictionary: [Int : Int]) -> [(key: Int, value: Int)] {
        
        return dictionary.sorted { lhs, rhs in
            if lhs.value != rhs.value {
                return lhs.value > rhs.value
            } else {
                return lhs.key > rhs.key
            }
        }
    }
    
}
