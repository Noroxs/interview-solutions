//
//  GeneratorTests.swift
//  eNoteInterviewTests
//
//  Created by Ramson, Thomas on 2/23/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import XCTest
@testable import eNoteInterview

class GeneratorTests: XCTestCase {

    // MARK: - RandomGenerator Tests
    
    func testGivenStaticRangeCalculatorWhenGeneratingSeveralNumbersThenTheValuesShouldNeverBeEqual() {
        
        let staticRange = StaticRangeCalculator(staticNumbersRange: Array(0...9))
        let randomGenerator = RandomGenerator(rangeCalculator: staticRange)
        
        var testSet: Set<[Int]> = []
        
        for _ in 0 ..< 10 {
            let randomNumbers = randomGenerator.generateNumbers(amount: 10)
            testSet.update(with: randomNumbers)
        }
        
        XCTAssertEqual(testSet.count, 10, "All 10 runs should create different random numbers")
    }

    func testGivenStaticRangeCalculatorWhenGeneratingSeveralNumbersThenGeneratedNumbersShouldAlwaysBeWithinTheGivenRange() {
        
        let minRangeValue = -1
        let maxRangeValue = 2
        let staticRange = StaticRangeCalculator(staticNumbersRange: [minRangeValue, maxRangeValue])
        let randomGenerator = RandomGenerator(rangeCalculator: staticRange)
        
        for _ in 0 ..< 10 {
            let randomNumbers = randomGenerator.generateNumbers(amount: 10)
            let valuesOutsideTheRange = randomNumbers.filter { $0 < minRangeValue || $0 > maxRangeValue }
            
            XCTAssertTrue(valuesOutsideTheRange.isEmpty, "Random generated numbers should always be within the given range")
        }
    }
    
    // MARK: - IntervalRandomGenerator Test
    
    func testGivenStaticRangeCalculatorAndDefaultIntervalWhenGeneratingSeveralNumbersThenTheValuesShouldNeverBeEqual() {
        
        let staticRange = StaticRangeCalculator(staticNumbersRange: Array(0...9))
        let randomGenerator = IntervalRandomGenerator(rangeCalculator: staticRange)
        
        var testSet: Set<[Int]> = []
        
        for _ in 0 ..< 10 {
            let randomNumbers = randomGenerator.generateNumbers(amount: 10)
            testSet.update(with: randomNumbers)
        }
        
        XCTAssertEqual(testSet.count, 10, "All 10 runs should create different random numbers")
    }
    
    func testGivenStaticRangeCalculatorAndDefaultIntervalWhenGeneratingSeveralNumbersThenGeneratedNumbersShouldAlwaysBeWithinTheGivenRange() {
        
        let minRangeValue = -1
        let maxRangeValue = 2
        let staticRange = StaticRangeCalculator(staticNumbersRange: [minRangeValue, maxRangeValue])
        let intervalGenerator = IntervalRandomGenerator(rangeCalculator: staticRange)
        
        for _ in 0 ..< 10 {
            let randomNumbers = intervalGenerator.generateNumbers(amount: 10)
            let valuesOutsideTheRange = randomNumbers.filter { $0 < minRangeValue || $0 > maxRangeValue }
            
            XCTAssertTrue(valuesOutsideTheRange.isEmpty, "Random generated numbers should always be within the given range")
        }
    }
    
    func testGivenIntervalOfTwoWhenGeneratingThreeNumbersThenItShouldTakeThreeIntervalsToFinishTheCreation() {
        
        let intervalGenerator = IntervalRandomGenerator(intervalSize: 2)
        
        let _ = intervalGenerator.generateNumbers(amount: 3)
        
        XCTAssertFalse(intervalGenerator.finished, "Process shouldn't be finished by now")
        
        let _ = intervalGenerator.continue()
        
        XCTAssertTrue(intervalGenerator.finished, "Process should be finished after one continue call")
    }
    
    func testGivenIntervalRandomGeneratorWhenCallingContinueBeforeGenerateNumbersThenRandomNumbersShouldBeEmpty() {
        
        let intervalGenerator = IntervalRandomGenerator()
        
        let randomNumbers = intervalGenerator.continue()
        
        XCTAssertTrue(randomNumbers.isEmpty, "Calling continue before generateNumbers should lead to an empty number array")
        
    }
    
    func testGivenIntervalRandomGeneratorWhenCallingContinueBeforeGenerateNumbersThenProcessIsNotFinished() {
        
        let intervalGenerator = IntervalRandomGenerator()
        
        let _ = intervalGenerator.continue()
        
        XCTAssertFalse(intervalGenerator.finished, "Calling continue before generateNumbers then process should not be finished")
    }

    func testGivenZeroNumberToGenerateWhenGenerateNumbersCalledThenItShouldReturnEmptyArray() {
        
        let intervalGenerator = IntervalRandomGenerator()
        
        let randomNumbers = intervalGenerator.generateNumbers(amount: 0)
        
        XCTAssertTrue(randomNumbers.isEmpty, "Calling generate with amount of 0 should return empty array")
    }
    
    func testGivenNegativNumberToGenerateWhenGenerateNumbersCalledThenItShouldReturnEmptyArray() {
        
        let intervalGenerator = IntervalRandomGenerator()
        
        let randomNumbers = intervalGenerator.generateNumbers(amount: -10)
        
        XCTAssertTrue(randomNumbers.isEmpty, "Calling generate with amount of negativ number should return empty array")
    }
    
    func testGivenZeroNumberToGenerateWhenGenerateNumbersCalledThenProcessShouldBeFinished() {
        
        let intervalGenerator = IntervalRandomGenerator()
        
        let _ = intervalGenerator.generateNumbers(amount: 0)
        
        XCTAssertTrue(intervalGenerator.finished, "Calling generate with amount of 0 should finish process")
    }
    
    func testGivenNegativNumberToGenerateWhenGenerateNumbersCalledThenProcessShouldBeFinished() {
        
        let intervalGenerator = IntervalRandomGenerator()
        
        let _ = intervalGenerator.generateNumbers(amount: -10)
        
        XCTAssertTrue(intervalGenerator.finished, "Calling generate with amount of negativ number should finish process")
    }
    
    func testGivenAmountOf13AndAnIntervalOf5WhenUsingIntervalMechanicThen13NumbersShouldBeGenerated() {

        let interval = 5
        let amount = 13
        let intervalGenerator = IntervalRandomGenerator(intervalSize: interval)

        var randomNumbers = intervalGenerator.generateNumbers(amount: amount)
        
        XCTAssertEqual(randomNumbers.count, interval, "First run should generate same amount as interval")
        
        let secondInterval = intervalGenerator.continue()
        randomNumbers += secondInterval
        
        XCTAssertEqual(secondInterval.count, interval, "Second run should generate same amount as interval")

        let thirdInterval = intervalGenerator.continue()
        randomNumbers += thirdInterval
        
        XCTAssertEqual(thirdInterval.count, 3, "Third run should generate 3 numbers")
        XCTAssertEqual(randomNumbers.count, amount, "When process is finished the generator should generate as many items as given amount")
    }
    
}
