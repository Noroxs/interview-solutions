//
//  WorkerIntegrationTests.swift
//  eNoteInterviewTests
//
//  Created by Ramson, Thomas on 2/23/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import XCTest
@testable import eNoteInterview

class WorkerIntegrationTests: XCTestCase {

    func testGivenAmountOf10WhenStartProcessSeveralTimesThenResultsShouldAlwaysBeDifferent() {
        
        let worker = IntervalWorker(intervalGenerator: IntervalRandomGenerator(intervalSize: 5))
        
        let runs = 10
        let amount = 20
        
        let finishExeption = expectation(description: "Proccess should finish")
        var resultSets: Set<[ValueEntity<Int>]> = []
        var processesFinished = 0
        
        worker.result.bind { value, finished in
            
            // current process is finished -> store data
            if finished == true {
                processesFinished += 1
                resultSets.update(with: value)
            }
            
            // current process is finished but still runs needed -> start next process
            if finished == true && processesFinished < runs {
                worker.startCreationSortingAndMapping(for: amount)
            }
            
            // all proceeses are finished check results
            if processesFinished == runs {
                finishExeption.fulfill()
            }
        }
        
        worker.startCreationSortingAndMapping(for: amount)
        
        waitForExpectations(timeout: 2.0, handler: nil)
        
        XCTAssertEqual(resultSets.count, runs, "Every run should produce a unique ")
        XCTAssertEqual(processesFinished, runs, "All processes should finish")
    }

}
