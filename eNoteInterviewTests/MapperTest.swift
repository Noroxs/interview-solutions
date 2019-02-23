//
//  MapperTest.swift
//  eNoteInterviewTests
//
//  Created by Ramson, Thomas on 2/23/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import XCTest
@testable import eNoteInterview

class MapperTest: XCTestCase {

    let testSortedNumbers = [(key: 5, value: 2), (key: 1, value: 2), (key: 11, value: 1), (key: 3, value: 1), (key: -2, value: 1)]
    let testMappedNumbers = [ValueEntity(5, amount: 2), ValueEntity(1, amount: 2), ValueEntity(11, amount: 1), ValueEntity(3, amount: 1), ValueEntity(-2, amount: 1)]
    
    func testGivenSortedNumbersWhenMappingThenValuesEntitiesShouldBeMappedCorrectly() {
        
        let mapper = Mapper()
        
        let mappedNumbers = mapper.mapToValueEntities(sortedNumbers: testSortedNumbers)
        XCTAssertEqual(mappedNumbers, testMappedNumbers, "Mapping should create correct ValueEnteties with correct order")
    }

}
