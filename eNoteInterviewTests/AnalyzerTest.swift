//
//  AnalyzerTest.swift
//  eNoteInterviewTests
//
//  Created by Ramson, Thomas on 2/23/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import XCTest
@testable import eNoteInterview

class AnalyzerTest: XCTestCase {

    // MARK: - Analyzer Tests
    
    func testGivenRandomListOfNumbersWhenAnalyzingThenDictionaryShouldBeAnalyzedCorrectly() {
        
        let numbers = StaticGenerator().generateNumbers(amount: 0)
        let analyzer = Analyzer()
        
        let analyzedNumbers = analyzer.analyze(numbers: numbers)
        
        let isAnalyzedCorrectly = isCorrectlyAnalyzed(analyzedDictionary: analyzedNumbers)
        XCTAssertTrue(isAnalyzedCorrectly, "Numbers should be analyzed correctly")
    }
    
    // MARK: - MemoryAnalyzer Test
    
    func testGivenMemoryStorageAnalyzerWhenCallingAnalyzeSeveralTimeThenAllNumbersShouldBeAnalyzedCorrectly() {
        
        let firstInterval = [1, 3, 5]
        let secondInterval = [-2, 1, 5]
        let thirdInterval = [11]
        
        let memoryAnalyzer = MemoryStorageAnalyzer()
        
        let _ = memoryAnalyzer.analyze(numbers: firstInterval)
        let _ = memoryAnalyzer.analyze(numbers: secondInterval)
        let analyzedNumbers = memoryAnalyzer.analyze(numbers: thirdInterval)
        
        let isAnalyzedCorrectly = isCorrectlyAnalyzed(analyzedDictionary: analyzedNumbers)
        XCTAssertTrue(isAnalyzedCorrectly, "Numbers should be analyzed correctly")
    }
    
    func testGivenMemoryStorageAnalyzerWhenCallingAnalyzeSeveralTimeThenReturnedValueShouldBeEqualToVariableValue() {
        
        let firstInterval = [1, 3, 5]
        let secondInterval = [-2, 1, 5, 11]
        
        let memoryAnalyzer = MemoryStorageAnalyzer()
        
        var analyzedNumbers = memoryAnalyzer.analyze(numbers: firstInterval)
        var savedAnalyzedNumbers = memoryAnalyzer.analyzedNumbers
        XCTAssertEqual(analyzedNumbers, savedAnalyzedNumbers, "Analyzed numbers returned and in memory should be equal")
        
        analyzedNumbers = memoryAnalyzer.analyze(numbers: secondInterval)
        savedAnalyzedNumbers = memoryAnalyzer.analyzedNumbers
        XCTAssertEqual(analyzedNumbers, savedAnalyzedNumbers, "Analyzed numbers returned and in memory should be equal")
    }
    
    func testGivenMemoryStorageAnalyzerWhenCallingAnalyzeAndAfterwardsClearThenReturnedSavedDataSouldBeEmpty() {
        
        let numbers = StaticGenerator().generateNumbers(amount: 0)
        let memoryAnalyzer = MemoryStorageAnalyzer()
        
        let _ = memoryAnalyzer.analyze(numbers: numbers)
        
        var isMemoryDataEmpty = memoryAnalyzer.analyzedNumbers.isEmpty
        XCTAssertFalse(isMemoryDataEmpty, "After performing analyze the memory should not be empty")
        
        memoryAnalyzer.clear()
        
        isMemoryDataEmpty = memoryAnalyzer.analyzedNumbers.isEmpty
        XCTAssertTrue(isMemoryDataEmpty, "After performing clear the memory should be empty")
    }
    
    func testGivenMemoryStorageAnalyzerWhenCallingAnalyzeSeveralTimesButClearsInbetweenThenReturnedValueShouldOnlyContainLastIntervalNumbers() {
        
        let firstInterval = [1, 3, 5, -2, 1, 5]
        let secondInterval = [11]
        let testAnalyzedData = [11: 1]
        
        let memoryAnalyzer = MemoryStorageAnalyzer()
        
        var _ = memoryAnalyzer.analyze(numbers: firstInterval)
        
        memoryAnalyzer.clear()
        
        let analyzedNumbers = memoryAnalyzer.analyze(numbers: secondInterval)
        XCTAssertEqual(analyzedNumbers, testAnalyzedData, "Analyzed numbers should only contain one value")
        
        let savedAnalyzedNumbers = memoryAnalyzer.analyzedNumbers
        XCTAssertEqual(savedAnalyzedNumbers, testAnalyzedData, "Stored numbers should only contain one value")
    }
    
    // MARK: - Helper methods
    
    private func isCorrectlyAnalyzed(analyzedDictionary: [Int : Int]) -> Bool {
        
        var isCorrectlyAnalyzed = true
        
        for (value, amount) in analyzedDictionary {
            if isValidPair(value: value, amount: amount) == false {
                isCorrectlyAnalyzed = false
                break
            }
        }
        
        return isCorrectlyAnalyzed
    }
    
    private func isValidPair(value: Int, amount: Int) -> Bool {

        if value == 1 && amount == 2 { return true }
        else if value == 5 && amount == 2 { return true }
        else if value == 11 && amount == 1 { return true }
        else if value == 3 && amount == 1 { return true }
        else if value == -2 && amount == 1 { return true }
        else { return false }
    }

}
