//
//  AccessibilityIdentifiers.swift
//  eNoteInterview
//
//  Created by Ramson, Thomas on 2/23/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import UIKit

enum AccessibilityIdentifiers: CustomStringConvertible {
    
    case amountTextField
    case executeButton
    case activityIndicator
    case tableView
    case tableViewCell(IndexPath)
    case valueLabel(IndexPath)
    case amountLabel(IndexPath)
    
    var description: String {
        switch self {
        case .amountTextField:
            return "AmountTextField"
        case .executeButton:
            return "ExecuteButton"
        case .activityIndicator:
            return "ActivityIndicator"
        case .tableView:
            return "TableView"
        case .tableViewCell(let indexPath):
            return "TableViewCell-\(indexPath.row)"
        case .valueLabel(_):
            return "ValueLabel"
        case .amountLabel(_):
            return "AmountLabel"
        }
    }
    
}
