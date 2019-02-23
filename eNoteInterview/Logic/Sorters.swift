//
//  Sorters.swift
//  eNoteInterview
//
//  Created by Ramson, Thomas on 2/22/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import UIKit

protocol Sorting {
    
    func sort(dictionary: [Int: Int]) -> [(key: Int, value: Int)]
    
}

extension Sorting {
    
    func sort(dictionary: [Int : Int]) -> [(key: Int, value: Int)] {
        
        return dictionary.sorted { lhs, rhs in
            if lhs.value != rhs.value {
                return lhs.value > rhs.value
            } else {
                return lhs.key > rhs.key
            }
        }
    }
    
}

struct StaticSorter: Sorting  {
    
    let staticSortedNumbers: [(key: Int, value: Int)]
    
    init(staticSortedNumbers: [(key: Int, value: Int)]) {
        
        self.staticSortedNumbers = staticSortedNumbers
    }
    
    func sort(dictionary: [Int: Int]) -> [(key: Int, value: Int)] {
        
        return staticSortedNumbers
    }
    
}

struct Sorter: Sorting { }
