//
//  RangeCalculatorTests.swift
//  eNoteInterviewTests
//
//  Created by Ramson, Thomas on 2/23/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import XCTest
@testable import eNoteInterview

class RangeCalculatorTests: XCTestCase {

    func testGivenMinRangeDivisorWhenCalculatingRangeThenMinimumRangeShouldBeCorrect() {
    
        let rangeCalculator = DivideRangeCalculator(minimumRangeDivisor: -3)
        
        let range = rangeCalculator.calculateRange(for: 30)
        
        let minumumRange = range.first!
        XCTAssertEqual(minumumRange, -10, "Minimum Range should be -10")
    }
    
    func testGivenMaxRangeDivisorWhenCalculatingRangeThenMaximumRangeShouldBeCorrect() {
        
        let rangeCalculator = DivideRangeCalculator(maximumRangeDivisor: 2)
        
        let range = rangeCalculator.calculateRange(for: 30)
        
        let maximumRange = range.last!
        XCTAssertEqual(maximumRange, 15, "Maximum Range should be 15")
    }
    
    func testGivenDivideRangeCalculatorWhenCalculatingRangeThenRangeArrayShouldContainCorrectCountOfItems() {
        
        let rangeCalculator = DivideRangeCalculator()
        
        let range = rangeCalculator.calculateRange(for: 30)
        
        let minumumRange = range.first!
        let maximumRange = range.last!
        
        let distance = minumumRange.distance(to: maximumRange) + 1
        XCTAssertEqual(range.count, distance, "Range should contain items equal to the distance between min and max range")
    }
    
    func testGivenDivideRangeCalculatorWhenCalculatingRangeThenRangeShouldOnlyContainItemsBetweenMinAndMaxRangeValues() {
        
        let rangeCalculator = DivideRangeCalculator()
        
        let range = rangeCalculator.calculateRange(for: 30)
        
        let minumumRange = range.first!
        let maximumRange = range.last!
        
        let incorrectRangeItems = range.filter { $0 <= minumumRange && $0 >= maximumRange }
        XCTAssertTrue(incorrectRangeItems.isEmpty, "All range items should be between te min \(minumumRange) and max \(maximumRange) range")
    }
    
    func testGivenZeroMaxRangeDivisorWhenCalculatingRangeThenRangeShouldBeEmpty() {
        
        let rangeCalculator = DivideRangeCalculator(maximumRangeDivisor: 0)
        
        let range = rangeCalculator.calculateRange(for: 30)
        
        XCTAssertTrue(range.isEmpty, "If maximumRangeDivisor is 0 range should be empty")
    }
    
    func testGivenZeroMinRangeDivisorWhenCalculatingRangeThenRangeShouldBeEmpty() {
        
        let rangeCalculator = DivideRangeCalculator(minimumRangeDivisor: 0)
        
        let range = rangeCalculator.calculateRange(for: 30)
        
        XCTAssertTrue(range.isEmpty, "If minimumRangeDivisor is 0 range should be empty")
    }
    
    func testGivenSmallerMinimumRangeDivisorCalculatingRangeThenRangeShouldBeEmpty() {
        
        let rangeCalculator = DivideRangeCalculator(minimumRangeDivisor: 1)
        
        let range = rangeCalculator.calculateRange(for: 30)
        
        XCTAssertTrue(range.isEmpty, "If minimumRangeDivisor is > maximumRangeDivisor range should be empty")
    }
    
    func testGivenSameRangeDivisorCalculatingRangeThenRangeShouldBeEmpty() {
        
        let rangeCalculator = DivideRangeCalculator(minimumRangeDivisor: 3, maximumRangeDivisor: 3)
        
        let range = rangeCalculator.calculateRange(for: 30)
        
        XCTAssertTrue(range.isEmpty, "If minimumRangeDivisor == maximumRangeDivisor range should be empty")
    }
    
}
