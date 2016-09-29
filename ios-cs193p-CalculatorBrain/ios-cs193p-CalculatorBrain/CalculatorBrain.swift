//
//  CalculatorBrain.swift
//  ios-cs193p-CalculatorBrain
//
//  Created by Emiliano on 9/28/16.
//  Copyright © 2016 Emiliano BARBOSA. All rights reserved.
//

import UIKit

func multiply(op1 :Double, op2 :Double) -> Double {
    return op1 * op2
}

class CalculatorBrain {
    
    private var accumulator = 0.0
    var result :Double {
        get {
            return accumulator
        }
    }
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    private var pending :PendingBinaryOperationInfo?
    
    private var operations :Dictionary<String, Operation> = [
        "π" : Operation.Constant(M_PI),
        "℮" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "×" : Operation.BinaryOperation({ $0 * $1 }),
        "÷" : Operation.BinaryOperation({ $0 / $1 }),
        "+" : Operation.BinaryOperation({ $0 + $1 }),
        "−" : Operation.BinaryOperation({ $0 - $1 }),
        "=" : Operation.Equals
    ]
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    
    func setOperand(operand :Double) {
        accumulator = operand
    }
    
    func performOperation(symbol :String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
}
