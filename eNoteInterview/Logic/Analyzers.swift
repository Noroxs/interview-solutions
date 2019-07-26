//
//  Analyzers.swift
//  eNoteInterview
//
//  Created by Ramson, Thomas on 2/22/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import UIKit

protocol Analyzing {

    func analyze(numbers: [Int]) -> [Int: Int]
    
    func clear()
    
}

extension Analyzing {
    
    func analyze(numbers: [Int]) -> [Int : Int] {
        
        return numbers.reduce(into: [Int: Int]()) { $0[$1, default: 0] += 1 }
    }
    
    func clear() {
        
    }
}

struct StaticAnalyzer: Analyzing {
    
    let staticAnalyzedNumbers: [Int : Int]
    
    init(staticAnalyzedNumbers: [Int : Int]) {
        
        self.staticAnalyzedNumbers = staticAnalyzedNumbers
    }
    
    func analyze(numbers: [Int]) -> [Int : Int] {
        
        return staticAnalyzedNumbers
    }

}
    
struct Analyzer: Analyzing { }

class MemoryStorageAnalyzer: Analyzing {
    
    var analyzedNumbers = [Int: Int]()
    
    func analyze(numbers: [Int]) -> [Int : Int] {
        
        analyzedNumbers = numbers.reduce(into: analyzedNumbers) { $0[$1, default: 0] += 1 }
        return analyzedNumbers
    }
    
    func clear() {
        
        analyzedNumbers = [:]
    }
    
}
