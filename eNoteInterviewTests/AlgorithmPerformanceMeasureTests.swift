//
//  eNoteInterviewTests.swift
//  eNoteInterviewTests
//
//  Created by Ramson, Thomas on 2/20/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import XCTest
@testable import eNoteInterview

class AlgorithmPerformanceMeasureTests: XCTestCase {

    // 1000 random generated numbers
    var numbers = [450, 468, -290, 158, -199, 41, 308, -62, 14, 286, 7, 92, -44, 83, 398, 412, 249, -275, 201, 329, -237, 332, 366, 301, -157, 207, 445, 21, 221, 10, 410, 388, -83, 193, -327, 309, 142, 229, -247, -107, -258, 231, 146, -209, -272, 314, -178, 411, -201, -294, -271, 253, 15, 333, -18, -83, 348, 114, 127, -288, -188, -100, 258, 5, -181, 126, 72, 31, 245, -101, 473, -29, -208, -7, -11, 309, 239, 105, 260, -199, -322, -203, 267, 77, -1, 19, 57, 333, 205, -294, 21, -172, 481, -107, -115, 74, -95, 352, 474, -255, 143, 370, -80, -87, 354, -229, -94, 405, 164, -211, -216, 353, 378, -71, 159, -327, 63, -164, 167, 244, 80, -176, 352, 192, 410, 48, -213, 168, -98, 362, 129, 300, 24, 16, 397, -226, 22, -154, 391, -87, -19, 258, 278, -125, 87, -17, 157, 388, -256, -65, 188, 393, -212, -320, 116, 195, -297, -120, 120, 374, 34, 357, 479, 275, 40, 348, 150, 481, 55, -288, 108, 416, 225, -289, 213, -229, 134, 327, 181, 427, 138, 367, 246, 355, -99, 358, -317, -20, 3, 20, -65, 453, 300, 72, -294, 132, 429, 436, 167, -220, -119, -147, 29, -180, 205, 240, -73, 262, -220, -28, -76, -248, 324, 66, 377, -16, -51, -187, 82, 498, 106, 415, 324, -323, 422, 211, -120, -326, 79, 176, -203, -143, -164, -116, 349, 247, 429, -136, 134, 348, 419, 91, 489, 325, 23, 141, 459, -260, 336, 414, 489, 340, -91, -156, -123, -201, -55, 249, 19, 121, -28, -188, -285, 67, -181, -58, -308, 81, 159, -233, 164, -272, 87, 121, 328, -81, 65, -251, 76, -82, 90, -321, -262, -87, -315, 173, -184, 456, 471, 120, -88, 56, 161, 8, -300, -169, 241, 470, 246, -9, 447, 334, -5, 387, 244, 217, -232, 420, 209, -233, -113, 311, 218, -79, -81, -186, -286, -249, 22, 402, -136, 219, 379, 22, -309, 483, 179, -277, -138, 339, 196, -192, 32, 377, -285, -86, -305, 108, 56, 281, 105, 43, -115, 471, -7, 328, 158, 464, 51, -268, 247, -236, -201, -41, 184, 66, -259, -74, -42, 327, 400, 118, -211, -315, -201, 492, 494, -39, -282, 326, 308, 132, 340, 389, -99, -301, 107, -318, -181, 115, 375, 476, -34, 444, 426, -93, 98, 293, -312, 498, -331, 383, -171, 349, -233, -155, -265, 259, -259, -146, -217, 7, 336, 172, -240, 62, -15, 486, -142, -104, 61, 228, 319, 63, 379, -276, 291, 129, 324, 15, 181, 260, -209, 259, -257, -115, -173, 65, 156, 128, 386, -274, 166, -110, 419, 213, 281, -131, -174, 219, -176, 229, -248, 239, -318, -164, 107, -8, -215, 189, 462, 459, -68, 53, -168, -269, -300, -123, 53, -13, 116, -70, 27, 146, 448, -47, -193, 395, 99, -151, -64, -33, -78, 315, 401, 151, -34, 244, 489, 96, 468, 11, -130, 155, 438, 341, 468, -278, 239, -259, 275, -31, -86, -1, 106, 210, 402, -52, 459, 246, 395, 120, 356, -22, 118, -258, 37, 363, -166, -203, 248, 107, -95, -141, 339, 191, 488, 8, 137, -217, -280, 285, 166, -26, 110, -327, 72, -34, 410, 144, -73, -180, 177, 337, -67, -18, 168, 444, -138, -221, -308, -104, -208, 190, -245, 115, 446, -3, -224, -265, -108, 44, -317, 216, 437, -259, -260, 121, 368, -300, -53, -103, 429, 280, 414, -130, 69, 232, -99, 435, -64, 285, 212, 480, -295, 86, 460, 32, 500, -263, 399, 358, -208, 495, 461, -179, 325, 204, 183, -317, -282, -108, -240, 124, -235, 151, 389, -222, 204, -102, 469, 421, 50, 158, 450, -187, 242, 348, -88, 483, 140, 165, -71, -211, 182, 367, 29, -9, 205, -293, 216, 107, 167, 98, -300, -2, -110, 262, 436, 23, -102, -192, -302, 448, -143, -8, -17, 447, 218, -169, -318, 381, 434, 206, -253, 201, -219, 64, -236, 264, 356, 281, 78, -223, -181, -10, 125, 43, -56, -93, 402, 303, 105, -286, 432, 7, 388, -81, -265, 389, 328, -44, 348, 115, 156, 106, 499, -107, 389, 344, 346, -69, -327, -301, 411, -255, 311, 50, 26, 315, -69, -197, -60, 73, 196, 458, 155, -54, 18, 79, 27, -290, -36, -15, 409, 207, 95, 172, -309, 105, -31, 2, 449, 376, 353, 389, 166, -266, 470, 203, 499, 493, 263, 422, 233, -152, -150, 134, 202, -140, 114, 159, 314, 238, -230, 25, 16, 468, -304, 364, 246, 226, 272, 163, 174, 303, -158, -255, 256, 284, -194, 35, 345, 51, 5, 45, -272, -182, -307, -192, -99, -239, 489, -3, 462, -270, 88, 166, -197, -104, -14, 325, 177, 321, 212, 424, 272, 325, -50, 184, 406, 22, -311, 190, -276, 393, 76, 202, -56, 178, 326, -326, -159, 493, 450, -17, -95, -41, 303, -115, 25, 186, 243, -267, -182, -270, -237, -308, -135, 350, -269, -157, 180, -188, -261, 255, -270, 436, -258, 453, 475, -156, 385, -294, -132, 320, 121, 238, 452, -265, -72, -216, 490, 292, -28, -190, 393, -317, -305, -10, 274, -24, -283, -120, -76, -149, 168, 412, 309, -262, 443, 494, 27, 252, -161, 407, -70, -162, 105, 480, 2, -261, 152, -308, 366, 194, 39, -187, -147, -64, 304, 78, 358, -321, 355, 281, -87, 322, 80, 459, -254, 478, -160, -137, 250, -123, -5, -114, 5, -224, -22, 76, 45, -207, -293, 97, 144, 227, -225, 31, 278, 455, -70, -256, -320, -127, -28, 58, 403, 415, 470, 152, -141, 294, -165, -205, 208, -277, -99, -229, -277, -219, 312, 41, 254, -191, 240, 209, 463, 294, 447, 426, 140, -273, -299, 186, 45, -127, 324, 2, -221, 499, -34, -123, 248, 296, 8, -29, -320, -210, 115, -162, -264, -55, -235, 257, 491, 396, 376, 313, 491, 162, 386, 405, 318, -45, -69, 8, 340, -218, 73, 411, -114, -193, 438, -245, -184, 211, -39, -150, -111, 152, 378, 213, -94, 1, 172, 409, 58, -48, 413, -92, 61, 346, -159, -316, -162, -147, 48, 381]

    // in -> [1, 3, 5, -2, 5, 11, 1]
    // out -> [1:2, 3:1, 5:2, -2:1, 11:1]
    func analyzeNumberOccurrence(in array: [Int]) -> [Int: Int] {
        
        return array.reduce(into: [Int: Int]()) { $0[$1, default: 0] += 1 }
    }
    
    // MARK: - Sort by using a dictionary
    
    func testPerformanceDictionarySort() {
        
        self.measure {
            combinedDictionarySort()
        }
    }

    // analyze number array convert it to dictionary sort dictionary and map it to ValueEntities
    func combinedDictionarySort() {
        
        let analyzedNumbersDictionary = analyzeNumberOccurrence(in: numbers)
        let sortedNumbers = sortAnalyzedNumberDictionary(analyzedNumbersDictionary)
        let _ = mapSortedNumbersToValueEntities(sortedNumbers)
    }
    
    // in -> [1:2, 3:1, 5:2, -2:1, 11:1]
    // out -> [5:2, 1:2, 11:1, 3:1, -2:1]
    func sortAnalyzedNumberDictionary(_ dictionary: [Int: Int]) -> [(key: Int, value: Int)] {
        
        return dictionary.sorted { lhs, rhs in
            if lhs.value != rhs.value {
                return lhs.value > rhs.value
            } else {
                return lhs.key > rhs.key
            }
        }
    }
    
    func mapSortedNumbersToValueEntities(_ sortedNumbers: [(key: Int, value: Int)]) -> [ValueEntity<Int>] {
        
        return sortedNumbers.map { ValueEntity($0, amount: $1) }
    }
    
    // MARK: - Sort by using a dictionary and set
    
    func testPerformSetSort() {
        
        self.measure {
            combinedSetSort()
        }
    }
    
    // analyze number array convert it to dictionary reverse dictionary and add all occurence numbers as sets and sort dictionary and map it to ValuesEntities
    func combinedSetSort() {
        
        let analyzedNumbersDictionary = analyzeNumberOccurrence(in: numbers)
        let convertedDictionary = convertToDictionaryWithAmountAsKeyAndValueAsOrderedSetConatiningAllValues(analyzedNumbersDictionary)
        let sortedSetDictionary = sortConvertedDictionary(convertedDictionary)
        let _ = mapSortedNumbersSetToValueEntities(sortedSetDictionary)
    }
    
    // in -> [1:2, 3:1, 5:2, -2:1, 11:1]
    // out -> [[2: <1, 5>], [1: <3, 11, -2>]]
    func convertToDictionaryWithAmountAsKeyAndValueAsOrderedSetConatiningAllValues(_ dictionary: [Int: Int]) -> [Int: NSOrderedSet] {
        
        return dictionary.reduce([Int: NSMutableOrderedSet]()) { result, keyValuePair in
            
            var result = result
            
            let element = result[keyValuePair.value, default: []]
            element.add(keyValuePair.key)
            
            result[keyValuePair.value] = element
            
            return result
        }
    }
    
    // in -> [[2: <1, 5>], [1: <3, 11, -2>]]
    // out -> [[2: [5, 1]], [1: [11, 3, -2]]]
    func sortConvertedDictionary(_ dictionary: [Int: NSOrderedSet]) -> [(key: Int, value: [Int])] {
        
        var sortedSetDictionary = [Int: [Int]]()
        
        dictionary.forEach { amount, valueSet in
            
            let sortedSet = valueSet.sortedArray(using: [NSSortDescriptor(key: nil, ascending: false)]) as? [Int] ?? []
            sortedSetDictionary[amount] = sortedSet
        }
        
        return sortedSetDictionary.sorted { $0.key > $1.key }
    }
    
    func mapSortedNumbersSetToValueEntities(_ sortedNumbers: [(key: Int, value: [Int])]) -> [ValueEntity<Int>] {
        
        var valueEntities = [ValueEntity<Int>]()
        
        sortedNumbers.forEach { amount, sortedSet in
            
            valueEntities += sortedSet.map { ValueEntity($0, amount: amount) }
        }
        
        return valueEntities
    }
    
}
