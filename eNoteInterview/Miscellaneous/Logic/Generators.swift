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

class IntervalRandomNumberGenerator: NumberGenerating, Intervalable {
    
    var rangeCalculator: NumberRangeCalculating
    var finished: DynamicBinding<Bool> = DynamicBinding(false)
    
    private let intervalSize: Int
    private var loopsToPerform: Int = 0
    private var leftoverAmount: Int = 0
    
    init(rangeCalculator: NumberRangeCalculating = DivideNumberRangeCalculator(), intervalSize: Int = 50000) {
        
        self.rangeCalculator = rangeCalculator
        self.intervalSize = intervalSize
    }
    
    func generateNumbers(amount: Int) -> [Int] {
        
        finished.value = false
        calculateNeededLoops(for: amount)
        
        return generateNextNumbers()
    }
    
    private func calculateNeededLoops(for amount: Int) {
        
        let positivAmount = max(amount, 0)
        
        loopsToPerform = positivAmount / intervalSize // example: amount = 123, interval = 50 -> amount / interval = 2 (because of int value no 0.xx values)
        leftoverAmount = positivAmount % intervalSize // example: amount = 123, interval = 50 -> amount % interval = 23
    }
    
    private func generateNextNumbers() -> [Int] {
        
        if loopsToPerform > 0 {
            loopsToPerform -= 1
            return generateRandomNumbers(amount: intervalSize)
        } else if leftoverAmount > 0 {
            finished.value = true
            return generateRandomNumbers(amount: leftoverAmount)
        } else {
            finished.value = true
            return []
        }
    }
    
    func `continue`() -> [Any] {
        
        return generateNextNumbers()
    }
    
}
