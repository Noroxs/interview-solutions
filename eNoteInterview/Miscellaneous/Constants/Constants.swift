//
//  Constants.swift
//  eNoteInterview
//
//  Created by Ramson, Thomas on 2/21/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import UIKit

struct Constants {
    
    static let validNumberCharacters = "0123456789"
    
    static let valueAmountTableViewCellIdentifier = "ValueAmountTableViewCellIdentifier"
 
    static let minimumRangeDivisor = -3
    static let maximumRangeDivisor = 2
    
    static func calculateMinimumRange(for amount: Int) -> Int {
        
        return amount / minimumRangeDivisor
    }
    
    static func calculateMaximumRange(for amount: Int) -> Int {
        
        return amount / maximumRangeDivisor
    }
    
}
