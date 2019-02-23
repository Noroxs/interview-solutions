//
//  XCUIElement+Helpers.swift
//  eNoteInterviewUITests
//
//  Created by Ramson, Thomas on 2/23/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import XCTest

// MARK: - TextField / SecureTextField
extension XCUIElement {
    
    /**
     Removes any current text in the TextField before typing in the new value
     - Parameter text: the text to enter into the field
     */
    func enterText(text: String) {
        
        guard elementType == .textField else {
            XCTFail("Tried to clear and enter text into a non textField element")
            return
        }
        
        tap()
        
        if let stringValue = value as? String,
            stringValue.isEmpty == false {

            let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
            typeText(deleteString)
        }
        
        typeText(text)
    }
    
    /**
     Return the entered value for textElements (e.g. textFields)
     */
    func enteredValue() -> String? {
        guard let textFieldValue = self.value as? String else {
            XCTFail("TextField should contain a value")
            return nil
        }
        
        return textFieldValue
    }
}
