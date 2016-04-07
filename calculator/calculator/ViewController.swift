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
    
    var userInTheMiddleOfTypingAVariable = false
    var brain = CalculatorBrain()
    var valueOfPi=M_PI
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userInTheMiddleOfTypingAVariable {
            if (display.text?.rangeOfString(".") == nil) || (display.text?.rangeOfString(".") != nil && digit != ".") {display.text = display.text! + digit}
        } else {
            display.text=digit
            userInTheMiddleOfTypingAVariable = true
        }
    }
    
    @IBAction func backspace(sender: UIButton) {
        if display.text!.characters.count > 1 {
            display.text = display.text!.substringToIndex(display.text!.endIndex.predecessor())
        } else {
            display.text = "0"
        }
    }
    
    @IBAction func changeSign(sender: UIButton) {
        if userInTheMiddleOfTypingAVariable {
            if display.text?.rangeOfString("-") == nil {
                display.text = "-" + display.text!
            } else {
                let newDisplayAfterChangingSign = display.text?.substringFromIndex(display.text!.startIndex.advancedBy(1))
                display.text = newDisplayAfterChangingSign
            }
        } else {
            operate(sender)
        }
    }

    @IBAction func clearEverything(sender: AnyObject) {
//        brain = CalculatorBrain()
        brain.clearAll()
        userInTheMiddleOfTypingAVariable = false
        display.text = "0"
        history.text = ""
    }
    
    
    @IBAction func enterPi(sender: UIButton) {
        enter()
        displayValue = valueOfPi
        enter()
    }
    @IBAction func operate(sender: UIButton) {
        if userInTheMiddleOfTypingAVariable {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
                history.text = history.text! + ",="
            } else {
                //well.. what if displayValue were optional
                displayValue = 0
            }
        }
    }
    
    @IBAction func enter() {
        userInTheMiddleOfTypingAVariable = false
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
            userInTheMiddleOfTypingAVariable = false
            history.text = brain.printStack()
        }
    }
    
}

