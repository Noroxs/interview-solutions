//
//  Generators.swift
//  eNoteInterview
//
//  Created by Ramson, Thomas on 2/21/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import UIKit

protocol NumberGenerating {
    
    var rangeCalculator: NumberRangeCalculating { get }
    
    func generateNumbers(amount: Int) -> [Int]
    
}

// MARK: - Random Number Generating methods

private extension NumberGenerating {
    
    func randomNumber(from range: [Int]) -> Int {
        
        return range.randomElement() ?? 0
    }
    
    func generateRandomNumbers(amount: Int) -> [Int] {
        
        let positivAmount = max(amount, 0)
        let range = rangeCalculator.calculateNumberRange(for: positivAmount)
        
        var randomNumbers = [Int]()
        for _ in 0 ..< positivAmount {
            let randomElement = randomNumber(from: range)
            randomNumbers.append(randomElement)
        }
        
        return randomNumbers
    }
    
}

struct StaticNumberGenerator: NumberGenerating {
    
    var rangeCalculator: NumberRangeCalculating = StaticNumberRangeCalculator()
    
    let staticNumberList: [Int]
    
    init(numberList: [Int]) {
        
        staticNumberList = numberList
    }
    
    func generateNumbers(amount: Int) -> [Int] {
        
        return staticNumberList
    }
    
}

struct RandomNumberGenerator: NumberGenerating {
    
    var rangeCalculator: NumberRangeCalculating
    
    init(rangeCalculator: NumberRangeCalculating = DivideNumberRangeCalculator()) {
        
        self.rangeCalculator = rangeCalculator
    }
    
    func generateNumbers(amount: Int) -> [Int] {
        
        return generateRandomNumbers(amount: amount)
    }
    
}
