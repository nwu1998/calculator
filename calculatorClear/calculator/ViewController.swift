//
//  ViewController.swift
//  calculator
//
//  Created by Nanyan Wu on 3/25/16.
//  Copyright © 2016 Nanyan Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!
    
    var userInTheMiddleOfTypingAnVariable = false
    var brain = CalculatorBrain()
    var valueOfPi=M_PI
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userInTheMiddleOfTypingAnVariable {
            if (display.text?.rangeOfString(".") == nil) || (display.text?.rangeOfString(".") != nil && digit != ".") {display.text = display.text! + digit}
        } else {
            display.text=digit
            userInTheMiddleOfTypingAnVariable = true
        }
    }
    

    @IBAction func clearEverything(sender: AnyObject) {
//        brain = CalculatorBrain()
        brain.clearAll()
        userInTheMiddleOfTypingAnVariable = false
        display.text = "0"
        history.text = ""
    }
    
    
    @IBAction func enterPi(sender: UIButton) {
        enter()
        display.text = "\(valueOfPi)"
        enter()
    }
    @IBAction func operate(sender: UIButton) {
        if userInTheMiddleOfTypingAnVariable {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                //well.. what if displayValue were optional
                displayValue = 0
            }
        }
    }
    
    @IBAction func enter() {
        userInTheMiddleOfTypingAnVariable = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            //well.....
            displayValue = 0
        }
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userInTheMiddleOfTypingAnVariable = false
            history.text = brain.printStack()
        }
    }
    
}

