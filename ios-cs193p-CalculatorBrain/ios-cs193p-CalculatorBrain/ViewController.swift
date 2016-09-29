//
//  ViewController.swift
//  ios-cs193p-CalculatorBrain
//
//  Created by Emiliano on 9/28/16.
//  Copyright © 2016 Emiliano BARBOSA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfTyping = false
    private var brain = CalculatorBrain()
    
    var displayValue :Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }

    @IBAction func touchDigit(_ sender: UIButton) {
        if (!userIsInTheMiddleOfTyping) {
            display.text = sender.currentTitle!
        } else {
            display.text? += sender.currentTitle!
        }
        userIsInTheMiddleOfTyping = true
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
        }
        userIsInTheMiddleOfTyping = false
        if let mathSymbol = sender.currentTitle {
            brain.performOperation(symbol: mathSymbol)
        }
        displayValue = brain.result
    }
    


}

