//
//  SorterTests.swift
//  eNoteInterviewTests
//
//  Created by Ramson, Thomas on 2/23/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import XCTest
@testable import eNoteInterview

class SorterTests: XCTestCase {

    let testAnalyzedNumbers = [1: 2, 11: 1, -2: 1, 5: 2, 3: 1]
    let testSortedNumbers = [(key: 5, value: 2), (key: 1, value: 2), (key: 11, value: 1), (key: 3, value: 1), (key: -2, value: 1)]
    
    func testGivenAnalyzedNumbersWhenCallingSortThenValuesShouldBeSortedCorrectly() {
        
        let sorter = Sorter()
        
        let sortedNumbers = sorter.sort(dictionary: testAnalyzedNumbers)
        
        let isCorrectlySorted = areNumbersCorrectlySorted(sortedNumbers: sortedNumbers)
        XCTAssertTrue(isCorrectlySorted, "Numbers should be sorted correctly")
    }
    
    private func areNumbersCorrectlySorted(sortedNumbers: [(key: Int, value: Int)]) -> Bool {
        
        var isSortedCorrectly = true
        
        for (index, pair) in sortedNumbers.enumerated() {
            let testPair = testSortedNumbers[index]
            
            guard pair.key == testPair.key && pair.value == testPair.value else {
                isSortedCorrectly = false
                break
            }
        }
        
        return isSortedCorrectly
    }
    
}
