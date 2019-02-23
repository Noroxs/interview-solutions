//
//  ViewModelTest.swift
//  eNoteInterviewTests
//
//  Created by Ramson, Thomas on 2/23/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import XCTest
@testable import eNoteInterview

class ViewModelTest: XCTestCase {

    func testGivenViewModelWhenNumberOfRowsIsCalledThenItReturnsTheCorrectAmount() {
        
        let worker = MockWorker(values: [ValueEntity(5), ValueEntity(2)], finished: true)
        let viewModel = ViewModel(textConverter: MockTextConverter(), worker: worker)
        
        var numberOfRows = viewModel.numberOfRows()
        XCTAssertEqual(numberOfRows, 0, "NumberOfRows should be initial 0")
        
        viewModel.startCreatingAndSorting(amountOfRandomNumbersText: "")
        
        numberOfRows = viewModel.numberOfRows()
        XCTAssertEqual(numberOfRows, 2, "NumberOfRows should be 2 after starting process")
    }

    func testGivenViewModelWhenResultAmountStringIsCalledThenItReturnsTheCorrectString() {
        
        let worker = MockWorker(values: [ValueEntity(5, amount: 2)], finished: true)
        let viewModel = ViewModel(textConverter: MockTextConverter(), worker: worker)
        
        viewModel.startCreatingAndSorting(amountOfRandomNumbersText: "")
        
        let amountString = viewModel.resultAmountString(at: IndexPath(row: 0, section: 0))
        XCTAssertEqual(amountString, "2", "resultAmountString should be 2")
    }
    
    func testGivenViewModelWhenResultValueStringIsCalledThenItReturnsTheCorrectString() {
        
        let worker = MockWorker(values: [ValueEntity(5, amount: 2)], finished: true)
        let viewModel = ViewModel(textConverter: MockTextConverter(), worker: worker)
        
        viewModel.startCreatingAndSorting(amountOfRandomNumbersText: "")
        
        let valueString = viewModel.resultValueString(at: IndexPath(row: 0, section: 0))
        XCTAssertEqual(valueString, "5", "resultAmountString should be 5")
    }
    
    func testGivenViewModelWhenProcessIsStartedThenActivityIndicatorShouldBeAnimating() {
        
        let worker = MockWorker(values: [ValueEntity(5, amount: 2)], finished: true)
        let viewModel = ViewModel(textConverter: MockTextConverter(), worker: worker)
        
        let startExpectation = expectation(description: "Indicator should start to animating")
        let stopExpectation = expectation(description: "Indicator should stop to animating")
        
        viewModel.executeActivityIndicatorAnimating.bind { isAnimating in
            
            if isAnimating {
                startExpectation.fulfill()
            } else {
                stopExpectation.fulfill()
            }
        }
        
        viewModel.startCreatingAndSorting(amountOfRandomNumbersText: "")
        
        waitForExpectations(timeout: 0.5, handler: nil)
    }
    
    func testGivenViewModelWhenProcessIsStartedThenTextFieldShouldBeToggledCorrectly() {
        
        let worker = MockWorker(values: [ValueEntity(5, amount: 2)], finished: true)
        let viewModel = ViewModel(textConverter: MockTextConverter(), worker: worker)
        
        let disableExpectation = expectation(description: "TextField should be disabled when process started")
        let enableExpectation = expectation(description: "TextField should be enabled wenn process finished")
        
        viewModel.isTextFieldEditable.bind { isEnabled in
            
            if isEnabled {
                enableExpectation.fulfill()
            } else {
                disableExpectation.fulfill()
            }
        }
        
        viewModel.startCreatingAndSorting(amountOfRandomNumbersText: "")
        
        waitForExpectations(timeout: 0.5, handler: nil)
    }
    
    func testGivenViewModelWhenProcessIsStartedThenExecuteButtonHiddenShouldBeToggledCorrectly() {
        
        let worker = MockWorker(values: [ValueEntity(5, amount: 2)], finished: true)
        let viewModel = ViewModel(textConverter: MockTextConverter(), worker: worker)
        
        let isHiddenExpectation = expectation(description: "Button should be hidden")
        let isVisibleExpectation = expectation(description: "Button should be visible")
        
        viewModel.isExecuteButtonHidden.bind { isHidden in
            
            if isHidden {
                isHiddenExpectation.fulfill()
            } else {
                isVisibleExpectation.fulfill()
            }
        }
        
        viewModel.startCreatingAndSorting(amountOfRandomNumbersText: "")
        
        waitForExpectations(timeout: 0.5, handler: nil)
    }
    
    func testGivenViewModelWhenProcessIsStartedThenResultIsCorrect() {
        
        let worker = MockWorker(values: [ValueEntity(5, amount: 2)], finished: true)
        let viewModel = ViewModel(textConverter: MockTextConverter(), worker: worker)
        
        let emptyExpectation = expectation(description: "Starting process should clear result")
        let valueExpectation = expectation(description: "Finishing process should deliver result")
        var numberOfCalles = 0
        
        viewModel.result.bind { result in
            numberOfCalles += 1
            
            if numberOfCalles == 1 && result.isEmpty {
                emptyExpectation.fulfill()
            } else if numberOfCalles == 2 && result.count == 1 {
                valueExpectation.fulfill()
            }
        }
        
        viewModel.startCreatingAndSorting(amountOfRandomNumbersText: "")
        
        waitForExpectations(timeout: 0.5, handler: nil)
    }
    
    func testGivenViewModelWhenAmountTextFieldWillClearIsCalledThenExecuteButtonShouldBeDisabled() {
        
        let viewModel = ViewModel(textConverter: MockTextConverter(), worker: MockWorker())
        
        let isDisbaledExpection = expectation(description: "Execute button should be disabled")
        
        viewModel.isExecuteButtonEnabled.bind { isEnabled in
            
            if isEnabled == false {
                isDisbaledExpection.fulfill()
            }
        }
        
        viewModel.amountTextFieldWillClear()
        
        waitForExpectations(timeout: 0.5, handler: nil)
    }
    
    func testGivenViewModelWhenAmountTextFieldShouldChangeIsCalledThenViewModelReturnsTrue() {
        
        let converter = MockTextConverter(onlyContainValidCharacters: true, containsValidNumber: true)
        let viewModel = ViewModel(textConverter: converter, worker: MockWorker())
        
        let shouldChange = viewModel.amountTextFieldShouldChangeCharactersIn(NSRange(location: 0, length: 0), replacementString: "", currentText: "")
        XCTAssertTrue(shouldChange, "ViewModel should allow character change")
    }
    
    func testGivenViewModelWhenAmountTextFieldShouldChangeIsCalledWithInvalidTextThenViewModelReturnsFalse() {
        
        let converter = MockTextConverter(onlyContainValidCharacters: false, containsValidNumber: false)
        let viewModel = ViewModel(textConverter: converter, worker: MockWorker())
        
        let shouldChange = viewModel.amountTextFieldShouldChangeCharactersIn(NSRange(location: 0, length: 0), replacementString: "", currentText: "")
        XCTAssertFalse(shouldChange, "ViewModel should not allow character change")
    }
    
    func testGivenViewModelWhenAmountTextFieldShouldChangeIsCalledWithValidNumberThenExecuteButtonShouldBeEnabled() {
        
        let converter = MockTextConverter(onlyContainValidCharacters: true, containsValidNumber: true)
        let viewModel = ViewModel(textConverter: converter, worker: MockWorker())
        
        let isEnabledExpection = expectation(description: "Execute button should be disabled")
        
        viewModel.isExecuteButtonEnabled.bind { isEnabled in
            
            if isEnabled == true {
                isEnabledExpection.fulfill()
            }
        }
        
        let _ = viewModel.amountTextFieldShouldChangeCharactersIn(NSRange(location: 0, length: 0), replacementString: "", currentText: "")
        
        waitForExpectations(timeout: 0.5, handler: nil)
    }
    
    func testGivenViewModelWhenAmountTextFieldShouldChangeIsCalledWithInvalidNumberThenExecuteButtonShouldBeDisabled() {
        
        let converter = MockTextConverter(onlyContainValidCharacters: true, containsValidNumber: false)
        let viewModel = ViewModel(textConverter: converter, worker: MockWorker())
        
        let isDisabledExpection = expectation(description: "Execute button should be disabled")
        
        viewModel.isExecuteButtonEnabled.bind { isEnabled in
            
            if isEnabled == false {
                isDisabledExpection.fulfill()
            }
        }
        
        let _ = viewModel.amountTextFieldShouldChangeCharactersIn(NSRange(location: 0, length: 0), replacementString: "", currentText: "")
        
        waitForExpectations(timeout: 0.5, handler: nil)
    }
    
    // MARK: - Mock classes
    
    private struct MockTextConverter: TextConverting {
        
        var validCharacters: String = ""
        
        let onlyContainValidCharacters: Bool
        let containsValidNumber: Bool
        
        init(onlyContainValidCharacters: Bool = true, containsValidNumber: Bool = true) {
            
            self.onlyContainValidCharacters = onlyContainValidCharacters
            self.containsValidNumber = containsValidNumber
        }
        
        func textOnlyContainValidCharacters(_ text: String) -> Bool {
            
            return onlyContainValidCharacters
        }
        
        func textContainsValidNumber(_ text: String) -> Bool {
            
            return containsValidNumber
        }
        
        func number(for text: String) -> Int {
            
            return 0
        }
        
    }
    
    private struct MockWorker: Working {
        
        var result: DynamicBinding<(values: [ValueEntity<Int>], finished: Bool)>
        
        init(values: [ValueEntity<Int>] = [], finished: Bool = true) {
            
            result = DynamicBinding((values: values, finished: finished))
        }
        
        func startCreationSortingAndMapping(for amount: Int) {
            
            result.value = result.value
        }
        
    }
    
}
