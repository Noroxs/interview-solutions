//
//  eNoteInterviewUITests.swift
//  eNoteInterviewUITests
//
//  Created by Ramson, Thomas on 2/20/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import XCTest
@testable import eNoteInterview

class eNoteInterviewUITests: XCTestCase {

    override func setUp() {
        
        continueAfterFailure = false
        
        let uiApplication = XCUIApplication()
        uiApplication.launchArguments = ["-UITestMode"]
        uiApplication.launch()
    }
    
    func testGivenSeveralTextsWhenEnteredIntoTextFieldThenTextFieldShouldOnlyConatinNumbersAndExecuteButtonShouldBeToggledCorrectly() {
        
        XCTAssertTrue(AccessibilityIdentifiers.amountTextField.isEnabled, "Text field should be enabled")
        
        XCTAssertFalse(AccessibilityIdentifiers.executeButton.isEnabled, "Execute button should be disabled")
        
        AccessibilityIdentifiers.amountTextField.element.enterText(text: "test!@=")
        
        XCTAssertTrue(AccessibilityIdentifiers.amountTextField.element.enteredValue()!.isEmpty, "Text should be empty because it only conatins invalid caharters")
        
        XCTAssertFalse(AccessibilityIdentifiers.executeButton.isEnabled, "Execute button should be disabled")
        
        AccessibilityIdentifiers.amountTextField.element.enterText(text: "-123")
        
        XCTAssertEqual(AccessibilityIdentifiers.amountTextField.element.enteredValue()!, "123", "Text should be 123 because - is illigal and filtered")
        
        XCTAssertTrue(AccessibilityIdentifiers.executeButton.isEnabled, "Execute button should be enabled when valid string is entered")
    }
    
    func testGivenValidNumberWhenEnteredAndExecuteButtonPressedThenTableViewShouldContainCorrectData() {

        AccessibilityIdentifiers.amountTextField.element.enterText(text: "123")
        
        XCTAssertTrue(AccessibilityIdentifiers.executeButton.isEnabled, "Execute button should be enabled when valid string is entered")
        AccessibilityIdentifiers.executeButton.tap()
        
        let cellsCount = AccessibilityIdentifiers.tableView.element.cells.count
        XCTAssertEqual(cellsCount, 5, "TableView should contain 5 items")
        
        let firstCellValue = AccessibilityIdentifiers.valueLabel(IndexPath(row: 0, section: 0)).label
        XCTAssertEqual(firstCellValue, "5", "First cell should contain value label 5")
        
        let firstCellAmount = AccessibilityIdentifiers.amountLabel(IndexPath(row: 0, section: 0)).label
        XCTAssertEqual(firstCellAmount, "2", "First cell should contain amount label 2")
    }

}
