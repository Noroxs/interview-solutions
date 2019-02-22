//
//  ViewModel.swift
//  eNoteInterview
//
//  Created by Ramson, Thomas on 2/21/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import UIKit

struct ViewModel {
    
    let executeActivityIndicatorAnimating: DynamicBinding<Bool> = DynamicBinding(false)
    let isExecuteButtonEnabled: DynamicBinding<Bool> = DynamicBinding(false)
    let isExecuteButtonHidden: DynamicBinding<Bool> = DynamicBinding(false)
    let isTextFieldEditable: DynamicBinding<Bool> = DynamicBinding(true)
    
    let result: DynamicBinding<[ValueEntity<Int>]> = DynamicBinding([])
    
    private let textConverter: TextToNumberConverter
    private let worker: NumberWorking
    
    init(textConverter: TextToNumberConverter = TextToNumberConverter(),
         worker: NumberWorking = NumberWorker()) {
        
        self.textConverter = textConverter
        self.worker = worker
    }
    
    func startCreatingAndSorting(amountOfRandomNumbersText: String?) {
        
        guard let text = amountOfRandomNumbersText,
            textConverter.textContainsValidNumber(text) else { return }
        
        startExecutingTask()
        
        let amountOfRandomNumbers = textConverter.number(for: text)
        createRandomArray(amount: amountOfRandomNumbers)
    }
    
    private func createRandomArray(amount: Int) {
        
        worker.result.bind { result in
            self.result.value = result.values
            if result.finished == true {
                self.finishExecutingTask()
            }
        }
        
        worker.startNumberCreationSortingAndMapping(for: amount)
    }
    
    // MARK: - Display tableview data source methods
    
    func numberOfRows() -> Int {
        
        return result.value.count
    }
    
    func resultAmountString(at indexPath: IndexPath) -> String {
        
        return result.value[indexPath.row].amountString
    }
    
    func resultValueString(at indexPath: IndexPath) -> String {
        
        return result.value[indexPath.row].valueString
    }
    
    // MARK: - Execute Button/Activity Indicator toggeling
    
    private func startExecutingTask() {
        
        result.value = []
        isTextFieldEditable.value = false
        executeActivityIndicatorAnimating.value = true
        isExecuteButtonHidden.value = true
    }
    
    private func finishExecutingTask() {
        
        isTextFieldEditable.value = true
        executeActivityIndicatorAnimating.value = false
        isExecuteButtonHidden.value = false
    }
    
    // MARK: - AmountTextField methods
    
    func amountTextFieldWillClear() {
        
        isExecuteButtonEnabled.value = false
    }
    
    func amountTextFieldShouldChangeCharactersIn(_ range: NSRange, replacementString string: String, currentText: String) -> Bool {
        
        let onlyContainsValidCharacters = textConverter.textOnlyContainValidCharacters(string)
        
        if onlyContainsValidCharacters == true {
            isExecuteButtonEnabled.value = textContainsValidNumber(range: range, replacementString: string, currentText: currentText)
        }
        
        return onlyContainsValidCharacters
    }
    
    private func textContainsValidNumber(range: NSRange, replacementString string: String, currentText: String) -> Bool {
        
        let enteredText = enteredTextFor(currentText: currentText, range: range, replacementString: string)
        return textConverter.textContainsValidNumber(enteredText)
    }
    
    private func enteredTextFor(currentText: String, range: NSRange, replacementString string: String) -> String {
        
        let currentTextAsNSString = currentText as NSString
        return currentTextAsNSString.replacingCharacters(in: range, with: string)
    }
    
}
