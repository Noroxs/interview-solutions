//
//  IntervalWorker.swift
//  eNoteInterview
//
//  Created by Ramson, Thomas on 2/22/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import UIKit

protocol Working {
    
    func startCreationSortingAndMapping(for amount: Int)
    
    var result: DynamicBinding<(values: [ValueEntity<Int>], finished: Bool)> { get }
    
}

struct Worker: Working {
    
    private let generator: Generating
    private let analyzer: Analyzing
    private let sorter: Sorting
    private let mapper: Mapping
    
    var result: DynamicBinding<(values: [ValueEntity<Int>], finished: Bool)> = DynamicBinding((values: [], finished: false))
    
    init(generator: Generating = RandomGenerator(),
         analyzer: Analyzing = Analyzer(),
         sorter: Sorting = Sorter(),
         mapper: Mapping = Mapper()) {
        
        self.generator = generator
        self.analyzer = analyzer
        self.sorter = sorter
        self.mapper = mapper
    }
    
    func startCreationSortingAndMapping(for amount: Int) {
        
        DispatchQueue.global(qos: .background).async {
            
            let generatedNumbers = self.generator.generateNumbers(amount: amount)
            let analyzedNumbers = self.analyzer.analyze(numbers: generatedNumbers)
            let sortedNumbers = self.sorter.sort(dictionary: analyzedNumbers)
            let mappedNumbers = self.mapper.mapToValueEntities(sortedNumbers: sortedNumbers)
            
            DispatchQueue.main.async {
                self.result.value = (mappedNumbers, true)
            }
        }
    }
    
}

struct IntervalWorker {
    
    private let intervalGenerator: IntervalGenerating
    
}
