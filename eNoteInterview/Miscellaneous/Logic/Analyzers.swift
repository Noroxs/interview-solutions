//
//  Analyzers.swift
//  eNoteInterview
//
//  Created by Ramson, Thomas on 2/22/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import UIKit

protocol NumberAnalyzing {

    func analyze(numbers: [Int]) -> [Int: Int]
    
}

struct StaticNumberAnalyzer: NumberAnalyzing  {
    
    let staticAnalyzedNumbers: [Int : Int]
    
    init(staticAnalyzedNumbers: [Int : Int]) {
        
        self.staticAnalyzedNumbers = staticAnalyzedNumbers
    }
    
    func analyze(numbers: [Int]) -> [Int : Int] {
        
        return staticAnalyzedNumbers
    }

}
    
struct NumberAnalyzer: NumberAnalyzing  {
    
    func analyze(numbers: [Int]) -> [Int : Int] {
        
        return numbers.reduce(into: [Int: Int]()) { $0[$1, default: 0] += 1 }
    }
    
}
