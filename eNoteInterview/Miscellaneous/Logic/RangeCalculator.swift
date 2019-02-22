//
//  RangeCalculator.swift
//  eNoteInterview
//
//  Created by Ramson, Thomas on 2/22/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import UIKit

protocol NumberRangeCalculating {
    
    func calculateNumberRange(for amount: Int) -> [Int]
    
}

struct StaticNumberRangeCalculator: NumberRangeCalculating  {
    
    let staticNumbersRange: [Int]
    
    init(staticNumbersRange: [Int] = []) {
        
        self.staticNumbersRange = staticNumbersRange
    }
    
    func calculateNumberRange(for amount: Int) -> [Int] {
        
        return staticNumbersRange
    }
    
}

struct DivideNumberRangeCalculator: NumberRangeCalculating {
    
    private let minimumRangeDivisor: Int
    private let maximumRangeDivisor: Int
    
    init(minimumRangeDivisor: Int = -3, maximumRangeDivisor: Int = 2) {
        
        self.minimumRangeDivisor = minimumRangeDivisor
        self.maximumRangeDivisor = maximumRangeDivisor
    }
    
    func calculateNumberRange(for amount: Int) -> [Int] {
        
        let minRange = calculateMinimumRange(for: amount)
        let maxRange = calculateMaximumRange(for: amount)
        
        return Array(minRange...maxRange)
    }
    
    private func calculateMinimumRange(for amount: Int) -> Int {
        
        return amount / minimumRangeDivisor
    }
    
    private func calculateMaximumRange(for amount: Int) -> Int {
        
        return amount / maximumRangeDivisor
    }
    
}
