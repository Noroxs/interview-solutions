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
    
    private var viewModel: ViewModel?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupViewModel()
        setupAccessibilityIdentifiers()
        setupViewBindings()
    }
    
    private func setupViewModel() {
        
        if CommandLine.arguments.contains("-UITestMode") {
            viewModel = ViewModel(worker: IntervalWorker(intervalGenerator: StaticGenerator()))
        } else {
            viewModel = ViewModel()
        }
    }
    
    private func setupAccessibilityIdentifiers() {
        
        amountTextField.accessibilityIdentifier = AccessibilityIdentifiers.amountTextField.description
        executeButton.accessibilityIdentifier = AccessibilityIdentifiers.executeButton.description
        executeActivityIndicatorView.accessibilityIdentifier = AccessibilityIdentifiers.activityIndicator.description
        resultTableView.accessibilityIdentifier = AccessibilityIdentifiers.tableView.description
    }
    
    private func setupViewBindings() {
    
        viewModel?.executeActivityIndicatorAnimating.bindAndFire { [weak self] isAnimating in
            if isAnimating {
                self?.executeActivityIndicatorView.startAnimating()
            } else {
                self?.executeActivityIndicatorView.stopAnimating()
            }
        }
        
        viewModel?.isExecuteButtonEnabled.bindAndFire { [weak self] isEnabled in
            self?.executeButton.isEnabled = isEnabled
        }
        
        viewModel?.isExecuteButtonHidden.bindAndFire { [weak self] isHidden in
            self?.executeButton.isHidden = isHidden
        }
        
        viewModel?.isTextFieldEditable.bindAndFire  { [weak self] isEditable in
            self?.amountTextField.isEnabled = isEditable
        }
     
        viewModel?.result.bind { [weak self] _ in
            self?.resultTableView.reloadData()
        }
        
    }
    
}

// MARK: - Action methods

extension ViewController {
    
    @IBAction func executeButtonWasPressed(_ sender: Any) {
        
        viewModel?.startCreatingAndSorting(amountOfRandomNumbersText: amountTextField.text)
    }
}

// MARK: - UITextFieldDelegate extension

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        viewModel?.startCreatingAndSorting(amountOfRandomNumbersText: amountTextField.text)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return viewModel?.amountTextFieldShouldChangeCharactersIn(range,
                                                                  replacementString: string,
                                                                  currentText: textField.text ?? "") ?? false
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        viewModel?.amountTextFieldWillClear()
        return true
    }
    
}

// MARK: - UITableViewDataSource extension

extension ViewController: UITableViewDataSource {
    
    private static let valueAmountTableViewCellIdentifier = "ValueAmountTableViewCellIdentifier"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.valueAmountTableViewCellIdentifier, for: indexPath)
        
        guard let amountValueCell = cell as? AmountValueTableViewCell,
            let viewModel = viewModel else { return cell }
        
        amountValueCell.accessibilityIdentifier = AccessibilityIdentifiers.tableViewCell(indexPath).description
        
        amountValueCell.valueLabel.text = viewModel.resultValueString(at: indexPath)
        amountValueCell.amountLabel.text = viewModel.resultAmountString(at: indexPath)
        
        return cell
    }
    
}
