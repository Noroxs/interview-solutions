//
//  Intervalable.swift
//  eNoteInterview
//
//  Created by Ramson, Thomas on 2/22/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import UIKit

protocol Intervalable {

    func `continue`() -> [Any]
    
    var finished: DynamicBinding<Bool> { get }
    
}

