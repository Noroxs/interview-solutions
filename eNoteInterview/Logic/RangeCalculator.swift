//
//  RangeCalculator.swift
//  eNoteInterview
//
//  Created by Ramson, Thomas on 2/22/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import UIKit

protocol RangeCalculating {
    
    func calculateRange(for amount: Int) -> [Int]
    
}

struct StaticRangeCalculator: RangeCalculating  {
    
    let staticRange: [Int]
    
    init(staticNumbersRange: [Int] = []) {
        
        self.staticRange = staticNumbersRange
    }
    
    func calculateRange(for amount: Int) -> [Int] {
        
        return staticRange
    }
    
}

struct DivideRangeCalculator: RangeCalculating {
    
    private let minimumRangeDivisor: Int
    private let maximumRangeDivisor: Int
    
    init(minimumRangeDivisor: Int = -3, maximumRangeDivisor: Int = 2) {
        
        self.minimumRangeDivisor = minimumRangeDivisor
        self.maximumRangeDivisor = maximumRangeDivisor
    }
    
    func calculateRange(for amount: Int) -> [Int] {
        
        guard minimumRangeDivisor != 0 && maximumRangeDivisor != 0 else { return [] }
        
        let positivAmount = max(amount, 0)
        let minRange = calculateMinimumRange(for: positivAmount)
        let maxRange = calculateMaximumRange(for: positivAmount)
        
        guard minRange < maxRange else { return [] }
        
        return Array(minRange...maxRange)
    }
    
    private func calculateMinimumRange(for amount: Int) -> Int {
        
        return amount / minimumRangeDivisor
    }
    
    private func calculateMaximumRange(for amount: Int) -> Int {
        
        return amount / maximumRangeDivisor
    }
    
}
