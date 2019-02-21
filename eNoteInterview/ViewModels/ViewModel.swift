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
    
    let result = [ValueEntity(5), ValueEntity(1), ValueEntity(11), ValueEntity(3), ValueEntity(-2)]
    
    private let textConverter = TextToNumberConverter()
    
    func startCreatingAndSorting(amountOfRandomNumbersText: String?) {
        
        guard let text = amountOfRandomNumbersText,
            textConverter.textContainsValidNumber(text) else { return }
        
        let amountOfRandomNumbers = textConverter.number(for: text)
        
        startExecutingTask()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.finishExecutingTask()
        }
    }
    
    // MARK: - Execute Button/Activity Indicator toggeling
    
    private func startExecutingTask() {
        
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
