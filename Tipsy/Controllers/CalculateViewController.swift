//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.2
    var numPeople = 2
    var inputTotal = 0.0
    var finalTotal = "0.0"
    
    @IBAction func billButton(_ sender: UITextField) {
        billTextField.text = sender.text
        inputTotal = Double(billTextField.text!)!
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        sender.isSelected = true
        
        let buttonTitleString = sender.currentTitle!.dropLast()
        tip = Double(buttonTitleString)! / 100.0
        print(tip)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        numPeople = Int(sender.value)
        splitNumberLabel.text =  String(numPeople)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        finalTotal = String(format: "%.2f", inputTotal * (1 + tip) / Double(numPeople))
        print(finalTotal)
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.totalString = finalTotal
            destinationVC.settingsString = "Split between \(numPeople) people, with \(tip * 100)% tip."
        }
    }
}

