//
//  AmountValueTableViewCell.swift
//  eNoteInterview
//
//  Created by Ramson, Thomas on 2/20/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import UIKit

class AmountValueTableViewCell: UITableViewCell {

    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        
        valueLabel.accessibilityIdentifier = AccessibilityIdentifiers.valueLabel(IndexPath()).description
        amountLabel.accessibilityIdentifier = AccessibilityIdentifiers.amountLabel(IndexPath()).description
    }
    
}
