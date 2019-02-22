//
//  IntervalWorker.swift
//  eNoteInterview
//
//  Created by Ramson, Thomas on 2/22/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import UIKit

protocol NumberWorking {
    
    func startNumberCreationSortingAndMapping(for amount: Int)
    
    var result: DynamicBinding<(values: [ValueEntity<Int>], finished: Bool)> { get }
    
}

struct NumberWorker: NumberWorking {
    
    private let generator: NumberGenerating
    private let analyzer: NumberAnalyzing
    private let sorter: NumberSorting
    private let mapper: NumberMapping
    
    var result: DynamicBinding<(values: [ValueEntity<Int>], finished: Bool)> = DynamicBinding((values: [], finished: false))
    
    init(generator: NumberGenerating = RandomNumberGenerator(),
         analyzer: NumberAnalyzing = NumberAnalyzer(),
         sorter: NumberSorting = NumberSorter(),
         mapper: NumberMapping = NumberMapper()) {
        
        self.generator = generator
        self.analyzer = analyzer
        self.sorter = sorter
        self.mapper = mapper
    }
    
    func startNumberCreationSortingAndMapping(for amount: Int) {
        
        DispatchQueue.global(qos: .background).async {
            
            let generatedNumbers = self.generator.generateNumbers(amount: amount)
            let analyzedNumbers = self.analyzer.analyze(numbers: generatedNumbers)
            let sortedNumbers = self.sorter.sortNumbers(dictionary: analyzedNumbers)
            let mappedNumbers = self.mapper.mapToValueEntities(sortedNumbers: sortedNumbers)
            
            DispatchQueue.main.async {
                self.result.value = (mappedNumbers, true)
            }
        }
    }
    
}
