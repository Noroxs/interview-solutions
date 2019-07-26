//
//  DynamicBinding.swift
//  eNoteInterview
//
//  Created by Ramson, Thomas on 2/20/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

class DynamicBinding<T> {
    
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
    
    func bind(_ listener: Listener?) {
        
        self.listener = listener
    }
    
    func bindAndFire(_ listener: Listener?) {
        
        self.listener = listener
        listener?(value)
    }
    
}
