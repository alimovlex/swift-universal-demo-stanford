//
//  ViewController.swift
//  Calculator
//
//  Created by robot on 2/28/21.
//  Copyright © 2021 robot. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet private weak var display: UILabel!;
    
    private var userIsInTheMiddleOfTyping = false;
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!;
        if userIsInTheMiddleOfTyping {
        let textCurrentlyInDisplay = display.text!;
        display.text = textCurrentlyInDisplay + digit;
        } else {
            display.text = digit;
        }
        userIsInTheMiddleOfTyping = true;
    }
    
   private var displayValue: Double {
        get {
            return Double(display.text!)!;
        }
        set {
            display.text = String(newValue);
        }
    }
    
    private var brain = CalculatorBrain();
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue);
            userIsInTheMiddleOfTyping = false;
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(symbol: mathematicalSymbol);
        }
        displayValue = brain.result;
    }
}


