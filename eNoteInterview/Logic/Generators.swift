//
//  Generators.swift
//  eNoteInterview
//
//  Created by Ramson, Thomas on 2/21/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import UIKit

protocol Generating {
    
    var rangeCalculator: RangeCalculating { get }
    
    func generateNumbers(amount: Int) -> [Int]
    
}

// MARK: - Random Number Generating methods

private extension Generating {
    
    func randomNumber(from range: [Int]) -> Int {
        
        return range.randomElement() ?? 0
    }
    
    func generateRandomNumbers(amount: Int, range: [Int]? = nil) -> [Int] {
        
        let positivAmount = max(amount, 0)
        let range = range ?? rangeCalculator.calculateRange(for: positivAmount)
        
        var randomNumbers = [Int]()
        for _ in 0 ..< positivAmount {
            let randomElement = randomNumber(from: range)
            randomNumbers.append(randomElement)
        }
        
        return randomNumbers
    }
    
}

class StaticGenerator: Generating {
    
    var rangeCalculator: RangeCalculating = StaticRangeCalculator()
    
    let staticList: [Int]
    
    init(list: [Int] = [1, 3, 5, -2, 1, 5, 11]) {
        
        staticList = list
    }
    
    func generateNumbers(amount: Int) -> [Int] {
        
        return staticList
    }
    
    // needed for extension Intervalable
    private var isFinished = false
}

extension StaticGenerator: Intervalable {
    
    func `continue`() -> [Int] {
        
        isFinished = true
        return staticList
    }
    
    var finished: Bool { return isFinished }
    
}

struct RandomGenerator: Generating {
    
    var rangeCalculator: RangeCalculating
    
    init(rangeCalculator: RangeCalculating = DivideRangeCalculator()) {
        
        self.rangeCalculator = rangeCalculator
    }
    
    func generateNumbers(amount: Int) -> [Int] {
        
        return generateRandomNumbers(amount: amount)
    }
    
}

typealias IntervalGenerating = Generating & Intervalable
class IntervalRandomGenerator: IntervalGenerating {
    
    var rangeCalculator: RangeCalculating
    var finished: Bool = false
    
    private let intervalSize: Int
    private var loopsToPerform: Int = 0
    private var leftoverAmount: Int = 0
    private var range: [Int] = []
    
    init(rangeCalculator: RangeCalculating = DivideRangeCalculator(), intervalSize: Int = 50000) {
        
        self.rangeCalculator = rangeCalculator
        self.intervalSize = intervalSize
        
    }
    
    func generateNumbers(amount: Int) -> [Int] {
        
        finished = false
        range = rangeCalculator.calculateRange(for: amount)
        calculateNeededLoops(for: amount)
        
        return generateNextNumbers()
    }
    
    private func calculateNeededLoops(for amount: Int) {
        
        let positivAmount = max(amount, 0)
        
        loopsToPerform = positivAmount / intervalSize // example: amount = 123, interval = 50 -> amount / interval = 2 (because of int value no 0.xx values)
        leftoverAmount = positivAmount % intervalSize // example: amount = 123, interval = 50 -> amount % interval = 23
    }
    
    private func generateNextNumbers() -> [Int] {
        
        var generatedNumbers: [Int] = []
        
        if loopsToPerform > 0 {
            
            generatedNumbers = generateRandomNumbers(amount: intervalSize, range: range)
            
            loopsToPerform -= 1
        } else if leftoverAmount > 0 {
            
            generatedNumbers = generateRandomNumbers(amount: leftoverAmount, range: range)
            
            leftoverAmount = 0
        }
        
        if loopsToPerform == 0 && leftoverAmount == 0 {
            finished = true
        }

        return generatedNumbers
    }
    
    func `continue`() -> [Int] {
        
        guard finished == false && (loopsToPerform > 0 || leftoverAmount > 0) else { return [] }
        
        return generateNextNumbers()
    }
    
}
