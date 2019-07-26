//
//  AccessibilityIdentifiers+UITestable.swift
//  eNoteInterviewUITests
//
//  Created by Ramson, Thomas on 2/23/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import UIKit
import XCTest
@testable import eNoteInterview

protocol UITestable {
    
    var element: XCUIElement { get }
    
}

extension UITestable {
    
    func tap() {
        
        element.tap()
    }
    
    var exists: Bool {
        
        return element.exists
    }
    
    var isEnabled: Bool {
        
        return element.isEnabled
    }
    
    var label: String {
        
        return element.label
    }
    
    func waitForExistence(timeout: TimeInterval) -> Bool {
        
        return element.waitForExistence(timeout: timeout)
    }
    
    func waitForElement(timeout: TimeInterval) -> XCUIElement? {
        
        let exits = waitForExistence(timeout: timeout)
        return exits ? element : nil
    }
    
}

extension AccessibilityIdentifiers: UITestable {
  
    var element: XCUIElement {
        
        switch self {
        case .amountTextField:
            return XCUIApplication().textFields[description].firstMatch
        case .executeButton:
            return XCUIApplication().buttons[description].firstMatch
        case .activityIndicator:
            return XCUIApplication().activityIndicators[description].firstMatch
        case .tableView:
            return XCUIApplication().tables[description].firstMatch
        case .tableViewCell(_):
            return AccessibilityIdentifiers.tableView.element.cells[description].firstMatch
        case .valueLabel(let indexPath),
             .amountLabel(let indexPath):
            return AccessibilityIdentifiers.tableViewCell(indexPath).element.staticTexts[description].firstMatch
        }
    }
    
}
