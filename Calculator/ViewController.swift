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
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operationSign: String = ""
    var currentInput: Double {
        get {
            return Double(displayResultLabel.text!)!
        }
        
        set {
            displayResultLabel.text = "\(newValue)"
            stillTyping = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        operationSign = (sender.titleLabel?.text)! // возможно тут ошибка
        firstOperand = currentInput
        stillTyping = false
        
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
//        guard operand2 != 0 else {
//            return nil
//        }
        return operand1 / operand2
    }
    
    @IBAction func equalitySignPressed(_ sender: UIButton) {
        
        if stillTyping {
            secondOperand = currentInput
        }
        
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
                    // Обработка деления на ноль
                    displayResultLabel.text = "Error"
                }
        default: break
        }
        
    }
    
    
}
