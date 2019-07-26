//
//  WorkerTests.swift
//  eNoteInterviewTests
//
//  Created by Ramson, Thomas on 2/23/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import XCTest
@testable import eNoteInterview

class WorkerTests: XCTestCase {

    private static let testResult = [ValueEntity(5, amount: 2), ValueEntity(1, amount: 2), ValueEntity(11, amount: 1), ValueEntity(3, amount: 1), ValueEntity(-2, amount: 1)]
    
    private let staticGenerator = StaticGenerator()
    private let staticAnalyzer = StaticAnalyzer(staticAnalyzedNumbers: [1: 2, 11: 1, -2: 1, 5: 2, 3: 1])
    private let staticSorter = StaticSorter(staticSortedNumbers: [(key: 5, value: 2), (key: 1, value: 2), (key: 11, value: 1), (key: 3, value: 1), (key: -2, value: 1)])
    private let staticMapper = StaticMapper(staticMappedNumbers: testResult)
    
    // MARK: Worker Tests
    
    func testGivenAmountOf10WhenStartingProcessThenShouldFinishAndGetCorrectResult() {
        
        let worker = Worker(generator: staticGenerator, analyzer: staticAnalyzer, sorter: staticSorter, mapper: staticMapper)
        
        let resultExpectation = expectation(description: "Worker should update results")
        var resultValues: [ValueEntity<Int>]?
        var resultFinished: Bool?
        
        worker.result.bind { values, finished in
            resultValues = values
            resultFinished = finished
            
            resultExpectation.fulfill()
        }
        
        worker.startCreationSortingAndMapping(for: 10)
        
        waitForExpectations(timeout: 0.5, handler: nil)
        
        XCTAssertEqual(resultValues, WorkerTests.testResult, "values should be correct")
        XCTAssertTrue(resultFinished!, "Process should be finished")
    }
    
    func testGivenAmountOfZeroWhenStartingProcessThenShouldFinishAndGetCorrectResult() {
        
        let worker = Worker(generator: staticGenerator, analyzer: staticAnalyzer, sorter: staticSorter, mapper: staticMapper)
        
        let resultExpectation = expectation(description: "Worker should update results")
        var resultValues: [ValueEntity<Int>]?
        var resultFinished: Bool?
        
        worker.result.bind { values, finished in
            resultValues = values
            resultFinished = finished
            
            resultExpectation.fulfill()
        }
        
        worker.startCreationSortingAndMapping(for: 0)
        
        waitForExpectations(timeout: 0.5, handler: nil)
        
        XCTAssertTrue(resultValues!.isEmpty, "values should empty when amount is 0")
        XCTAssertTrue(resultFinished!, "Process should be finished")
    }
    
    func testGivenNegativeAmountWhenStartingProcessThenShouldFinishAndGetCorrectResult() {
        
        let worker = Worker(generator: staticGenerator, analyzer: staticAnalyzer, sorter: staticSorter, mapper: staticMapper)
        
        let resultExpectation = expectation(description: "Worker should update results")
        var resultValues: [ValueEntity<Int>]?
        var resultFinished: Bool?
        
        worker.result.bind { values, finished in
            resultValues = values
            resultFinished = finished
            
            resultExpectation.fulfill()
        }
        
        worker.startCreationSortingAndMapping(for: -10)
        
        waitForExpectations(timeout: 0.5, handler: nil)
        
        XCTAssertTrue(resultValues!.isEmpty, "values should empty when amount is negativ")
        XCTAssertTrue(resultFinished!, "Process should be finished")
    }
    
    // MARK: IntervalWorker Test
    
    func testGivenAmountOfTenWhenStartingProcessThenResultShouldBeUpdatedTwice() {
        
        let staticIntervalGenerator = StaticGenerator(numberOfIntervales: 2)
        let intervalWorker = IntervalWorker(intervalGenerator: staticIntervalGenerator, analyzer: staticAnalyzer, sorter: staticSorter, mapper: staticMapper)
        
        let firstResultExpectation = expectation(description: "Worker should update results")
        let secondResultExpectation = expectation(description: "Worker should update results")
        
        var numbersOfResultUpdates = 0
        var resultValues: [ValueEntity<Int>]?
        var resultFinished: Bool?
        
        intervalWorker.result.bind { values, finished in
            numbersOfResultUpdates += 1
            
            if numbersOfResultUpdates == 1 && finished == true {
                XCTFail("Experct results to be updatet twice")
            } else if numbersOfResultUpdates == 2 && finished == false {
                XCTFail("Experct results to be updatet twice")
            }
            
            resultValues = values
            resultFinished = finished
            
            if numbersOfResultUpdates == 1 {
                firstResultExpectation.fulfill()
            } else if numbersOfResultUpdates == 2 {
                secondResultExpectation.fulfill()
            } else {
                XCTFail("Results should only be updated twice")
            }
        }
        
        intervalWorker.startCreationSortingAndMapping(for: 10)
        
        waitForExpectations(timeout: 1.0, handler: nil)
        
        XCTAssertEqual(numbersOfResultUpdates, 2, "Worker should update result twice")
        XCTAssertEqual(resultValues, WorkerTests.testResult, "values should be correct")
        XCTAssertTrue(resultFinished ?? false, "Process should be finished")
    }
    
    func testGivenAmountOfZeroWhenStartingProcessThenResultShouldBeUpdatedTwice() {
        
        let staticIntervalGenerator = StaticGenerator()
        let intervalWorker = IntervalWorker(intervalGenerator: staticIntervalGenerator, analyzer: staticAnalyzer, sorter: staticSorter, mapper: staticMapper)
        
        let resultExpectation = expectation(description: "Worker should update results")
        var resultValues: [ValueEntity<Int>]?
        var resultFinished: Bool?
        
        intervalWorker.result.bind { values, finished in
            
            resultValues = values
            resultFinished = finished
            
            resultExpectation.fulfill()
        }
        
        intervalWorker.startCreationSortingAndMapping(for: 0)
        
        waitForExpectations(timeout: 0.5, handler: nil)
        
        XCTAssertTrue(resultValues!.isEmpty, "values should empty when amount is 0")
        XCTAssertTrue(resultFinished!, "Process should be finished")
    }
    
    func testGivenNegativAmountWhenStartingProcessThenResultShouldBeUpdatedTwice() {
        
        let staticIntervalGenerator = StaticGenerator()
        let intervalWorker = IntervalWorker(intervalGenerator: staticIntervalGenerator, analyzer: staticAnalyzer, sorter: staticSorter, mapper: staticMapper)
        
        let resultExpectation = expectation(description: "Worker should update results")
        var resultValues: [ValueEntity<Int>]?
        var resultFinished: Bool?
        
        intervalWorker.result.bind { values, finished in
            
            resultValues = values
            resultFinished = finished
            
            resultExpectation.fulfill()
        }
        
        intervalWorker.startCreationSortingAndMapping(for: -10)
        
        waitForExpectations(timeout: 0.5, handler: nil)
        
        XCTAssertTrue(resultValues!.isEmpty, "values should empty when amount is negativ")
        XCTAssertTrue(resultFinished!, "Process should be finished")
    }
    
}
