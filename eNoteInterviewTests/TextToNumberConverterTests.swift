//
//  TextToNumberConverterTests.swift
//  eNoteInterviewTests
//
//  Created by Ramson, Thomas on 2/23/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import XCTest
@testable import eNoteInterview

class TextToNumberConverterTests: XCTestCase {

    var converter: TextToNumberConverter!
    
    override func setUp() {
        
        converter = TextToNumberConverter()
    }
    
    override func tearDown() {
        
        converter = nil
    }
    
    func testGivenNumberStringWhenTextOnlyContainValidCharactersIsCalledThenItShouldReturnTrue() {
        
        let validString = "1234567890"
        
        let onlyValidCharacters = converter.textOnlyContainValidCharacters(validString)
        
        XCTAssertTrue(onlyValidCharacters, "Text only contains valid characters. The converter should return true")
    }
    
    func testGivenEmptyStringWhenTextOnlyContainValidCharactersIsCalledThenItShouldReturnTrue() {
        
        let validString = ""
        
        let onlyValidCharacters = converter.textOnlyContainValidCharacters(validString)
        
        XCTAssertTrue(onlyValidCharacters, "Empty Text is considered as valid. The converter should return true")
    }
    
    func testGivenTextStringWhenTextOnlyContainValidCharactersIsCalledThenItShouldReturnFalse() {
        
        let invalidString = "HelloWorld-*&12354"
        
        let onlyValidCharacters = converter.textOnlyContainValidCharacters(invalidString)
        
        XCTAssertFalse(onlyValidCharacters, "Text contains invalid characters. The converter should return false")
    }
    
    func testGivenTextNegativNumberStringWhenTextOnlyContainValidCharactersIsCalledThenItShouldReturnFalse() {
        
        let invalidString = "-123"
        
        let onlyValidCharacters = converter.textOnlyContainValidCharacters(invalidString)
        
        XCTAssertFalse(onlyValidCharacters, "Text contains invalid characters. The converter should return false")
    }
    
    func testGivenNumberStringWhenCalledNumberForTextThenItShouldReturnTheCorrectIntValue() {
        
        let validString = "1234567809"
        
        let number = converter.number(for: validString)
        
        XCTAssertEqual(number, 1234567809, "Text only contains valid characters. The converter should create the int 1234567809")
    }
    
    func testGivenNumberStringWithBeginningZeroWhenCalledNumberForTextThenItShouldReturnTheCorrectIntValue() {
        
        let validString = "0123456789"
        
        let number = converter.number(for: validString)
        
        XCTAssertEqual(number, 123456789, "Text only contains valid characters but with a beginning 0. The converter should create the int 123456789")
    }

    func testGivenNegativNumberStringWhenCalledNumberForTextThenItShouldReturnTheZeroIntValue() {
        
        let invalidString = "-123"
        
        let number = converter.number(for: invalidString)
        
        XCTAssertEqual(number, 0, "Text contains negativ number the converter should return 0")
    }
    
    func testGivenRandomStringWhenCalledNumberForTextThenItShouldReturnTheZeroIntValue() {
        
        let invalidString = "HelloWorld-*&12354"
        
        let number = converter.number(for: invalidString)
        
        XCTAssertEqual(number, 0, "Text contains invalid characters the converter should return 0")
    }
    
    func testGivenEmptyStringWhenCalledNumberForTextThenItShouldReturnTheZeroIntValue() {
        
        let emptyString = ""
        
        let number = converter.number(for: emptyString)
        
        XCTAssertEqual(number, 0, "Text contains invalid characters the converter should return 0")
    }
    
    func testGivenNumberStringWhenCalledTextContainsValidNumberThenItShouldReturnTrue() {
        
        let validString = "1234567890"
        
        let containsValidNumber = converter.textContainsValidNumber(validString)
        
        XCTAssertTrue(containsValidNumber, "Text contains valid number. The converter should return true")
    }
    
    func testGivenZeroNumberStringWhenCalledTextContainsValidNumberThenItShouldReturnFalse() {
        
        let validString = "0"
        
        let containsValidNumber = converter.textContainsValidNumber(validString)
        
        XCTAssertFalse(containsValidNumber, "Text contains invalid number. The converter should return false")
    }
    
    func testGivenEmptyStringWhenCalledTextContainsValidNumberThenItShouldReturnFalse() {
        
        let invalidString = ""
        
        let containsValidNumber = converter.textContainsValidNumber(invalidString)
        
        XCTAssertFalse(containsValidNumber, "Text contains invalid number. The converter should return false")
    }
    
    func testGivenNegativNumberStringWhenCalledTextContainsValidNumberThenItShouldReturnFalse() {
        
        let negativString = "-1230"
        
        let containsValidNumber = converter.textContainsValidNumber(negativString)
        
        XCTAssertFalse(containsValidNumber, "Text contains invalid number. The converter should return false")
    }
    
    func testGivenRandomStringWhenCalledTextContainsValidNumberThenItShouldReturnFalse() {
        
        let invalidString = "HelloWorld-*&12354"
        
        let containsValidNumber = converter.textContainsValidNumber(invalidString)
        
        XCTAssertFalse(containsValidNumber, "Text contains invalid number. The converter should return false")
    }
    
}
