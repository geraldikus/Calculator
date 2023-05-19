//
//  ViewController.swift
//  Calculator
//
//  Created by Anton on 18.05.23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayResultLabel: UILabel!
    
    var stillTyping = false
    var dotIsPlaced = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operationSign: String = ""
    var currentInput: Double {
        get {
            return Double(displayResultLabel.text!)!
        }
        
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: String("."))
            
            if valueArray[1] == "0" {
                displayResultLabel.text = "\(valueArray[0])"
            } else {
                displayResultLabel.text = "\(newValue)"
            }
            
            stillTyping = false
        }
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        
        if let number = sender.titleLabel?.text {
                if stillTyping && displayResultLabel.text!.count < 20 {
                    displayResultLabel.text = displayResultLabel.text! + number
                } else {
                    displayResultLabel.text = number
                    stillTyping = true
                }
            }
    }
    
    @IBAction func twoOperandsSignPressed(_ sender: UIButton) {
        operationSign = (sender.titleLabel?.text)!
        firstOperand = currentInput
        stillTyping = false
        dotIsPlaced = false
    }
    
    func operationWithTwoOperand(operation: (Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
        stillTyping = false
    }
    
    func add(_ operand1: Double, _ operand2: Double) -> Double {
        return operand1 + operand2
    }
    
    func subtract(_ operand1: Double, _ operand2: Double) -> Double {
        return operand1 - operand2
    }

    func multiply(_ operand1: Double, _ operand2: Double) -> Double {
        return operand1 * operand2
    }
    
    func divide(_ operand1: Double, _ operand2: Double) -> Double? {
        guard operand2 != 0 else {
            return nil
        }
        return operand1 / operand2
    }
    
    @IBAction func equalitySignPressed(_ sender: UIButton) {
        
        if stillTyping {
            secondOperand = currentInput
        }
        
        dotIsPlaced = false
        
        switch operationSign {
        case "+":
            operationWithTwoOperand(operation: add)
        case "-":
            operationWithTwoOperand(operation: subtract)
        case "×":
            operationWithTwoOperand(operation: multiply)
        case "÷":
            if let result = divide(firstOperand, secondOperand) {
                    currentInput = result
            } else {
                    displayResultLabel.text = "Error"
                }
        default: break
        }
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        displayResultLabel.text = "0"
        firstOperand = 0.0
        secondOperand = 0.0
        currentInput = 0
        stillTyping = false
        dotIsPlaced = false
        operationSign = ""
    }
    
    @IBAction func plusMinusButtonPressed(_ sender: UIButton) {
        currentInput = -currentInput
    }
    
    @IBAction func percentageButtonPressed(_ sender: UIButton) {
        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            secondOperand = firstOperand * currentInput / 100
        }
        stillTyping = false
    }
    
    @IBAction func squareRootButtonPressed(_ sender: UIButton) {
        
        if currentInput > 0  {
            currentInput = sqrt(currentInput)
        } else {
            displayResultLabel.text = "Error"
        }
    }
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        if stillTyping && !dotIsPlaced {
            displayResultLabel.text = displayResultLabel.text! + "."
            dotIsPlaced = true
        } else if !stillTyping && !dotIsPlaced {
            displayResultLabel.text = "0."
            stillTyping = true
        }
    }
}
