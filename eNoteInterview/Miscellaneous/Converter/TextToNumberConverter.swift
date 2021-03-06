//
//  TextToNumberConverter.swift
//  eNoteInterview
//
//  Created by Ramson, Thomas on 2/21/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import UIKit

protocol TextConverting {
    
    var validCharacters: String { get }
    
    func textOnlyContainValidCharacters(_ text: String) -> Bool
    func textContainsValidNumber(_ text: String) -> Bool
    func number(for text: String) -> Int
    
}

struct TextToNumberConverter: TextConverting {
    
    var validCharacters = "0123456789"
    
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
        
        let number = Int(text) ?? 0
        return max(number, 0) // ensure number is positiv
    }
    
}
