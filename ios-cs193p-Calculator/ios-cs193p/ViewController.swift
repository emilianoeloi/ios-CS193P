//
//  ViewController.swift
//  ios-cs193p
//
//  Created by Emiliano on 9/26/16.
//  Copyright © 2016 Emiliano BARBOSA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var isFirstDigit = false

    @IBAction func touchDigit(_ sender: UIButton) {
        if (!isFirstDigit) {
            display.text = sender.currentTitle!
            isFirstDigit = true
        } else {
            display.text? += sender.currentTitle!
        }
    }
    
    var displayValue :Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        if let operation = sender.currentTitle {
            if operation == "π" {
                displayValue = M_PI
            }else if operation == "√" {
                displayValue = sqrt(displayValue)
            }
        }
    }


}

