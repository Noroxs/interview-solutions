//
//  ViewController.swift
//  eNoteInterview
//
//  Created by Ramson, Thomas on 2/20/19.
//  Copyright © 2019 Thomas Ramson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var executeActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var executeButton: UIButton!
    @IBOutlet weak var resultTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func executeButtonWasPressed(_ sender: Any) {
        

// MARK: - UITableViewDataSource extension

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    }
    
}
    }

}

