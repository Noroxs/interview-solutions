//
//  Generators.swift
//  eNoteInterview
//
//  Created by Ramson, Thomas on 2/21/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import UIKit

protocol NumberGenerating {
    
    var range: [Int] { get }
    
    func generateNumbers(amount: Int) -> [Int]
    
}

extension NumberGenerating {
    
    var randomElement: Int { return range.randomElement() ?? 0 }
    
}

struct StaticNumberGenerator: NumberGenerating {
    
    var range: [Int] = []
    
    let staticNumberList: [Int]
    
    init(numberList: [Int]) {
        
        staticNumberList = numberList
    }
    
    func generateNumbers(amount: Int) -> [Int] {
        
        return staticNumberList
    }
    
}

class RandomNumberGenerator: NumberGenerating {
    
    var range: [Int] = []
    
    func generateNumbers(amount: Int) -> [Int] {
        
        generateRange(for: amount)
        
        var randomNumbers = [Int]()
        for _ in 0 ..< amount {
            randomNumbers.append(randomElement)
        }
        
        return randomNumbers
    }
    
    private func generateRange(for amount: Int) {
        
        let minRange = Constants.calculateMinimumRange(for: amount)
        let maxRange = Constants.calculateMaximumRange(for: amount)
        
        range = Array(minRange...maxRange)
    }
    
    private struct Constants {
        
        static let minimumRangeDivisor = -3
        static let maximumRangeDivisor = 2
        
        static func calculateMinimumRange(for amount: Int) -> Int {
            
            return amount / minimumRangeDivisor
        }
        
        static func calculateMaximumRange(for amount: Int) -> Int {
            
            return amount / maximumRangeDivisor
        }
    }
    
}
