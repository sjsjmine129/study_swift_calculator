//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by 엄승주 on 12/9/23.
//

import Foundation


class CalculatorBrain{
    
    private var accumulator = 0.0
    
    func setOperand(operand:Double){
        accumulator = operand
    }
    
    //                          key   value: 상수, 함수등 여러 종류를 하기위해 아래에 따로 정의
    private var operations: Dictionary<String, Operation> = [
        "π" : Operation.Constant(Double.pi),
        "e" : Operation.Constant(M_E),
        "±" : Operation.UnaryOperation({-$0}),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "×" : Operation.BinaryOperation({ $0 * $1 }),
        "÷" : Operation.BinaryOperation({ $0 / $1 }),
        "+" : Operation.BinaryOperation({ $0 + $1 }),
        "−" : Operation.BinaryOperation({ $0 - $1 }),
        "=" : Operation.Equals
    ]
    
    //위에서 사용하기 위한 자료형 정의 by enum
   private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double)->Double) //Double을 인자로 받아서 Double을 리턴하는 함수
        case BinaryOperation((Double,Double)->Double)
        case Equals
    }
    
    func performOperation(symbol:String){
        if let operation = operations[symbol]{
            switch operation{
            case .Constant(let value): 
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOp: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation(){
        if pending != nil{
            accumulator = pending!.binaryFunction(pending!.firstOp,accumulator)
            pending = nil
        }
    }
    
    private var pending: PendingBinaryOperationInfo? //옵셔널 : 있을지 없을지 모름
    
    
    // 값으로 전달 됨
    private struct PendingBinaryOperationInfo{
        var binaryFunction: (Double,Double)->Double
        var firstOp: Double
    }
    
    //read only
    var result:Double{
        get{
            return accumulator
        }
    }
    
}
