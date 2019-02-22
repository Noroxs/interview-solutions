//
//  TextToNumberConverter.swift
//  eNoteInterview
//
//  Created by Ramson, Thomas on 2/21/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import UIKit

struct TextToNumberConverter {
    
    private let validCharacters = "0123456789"
    
    func textOnlyContainValidCharacters(_ text: String) -> Bool {
        
        let allowedCharacters = CharacterSet(charactersIn: validCharacters)
        let stringCharacterSet = CharacterSet(charactersIn: text)
        
        return allowedCharacters.isSuperset(of: stringCharacterSet)
    }
    
    func textContainsValidNumber(_ text: String) -> Bool {
        
        let textNumber = number(for: text)
        let isTextNumberValid = textNumber > 0
        
        return isTextNumberValid
    }
    
    func number(for text: String) -> Int {
        
        return Int(text) ?? 0
    }
    
}
