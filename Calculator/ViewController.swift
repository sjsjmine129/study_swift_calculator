//
//  ViewController.swift
//  Calculator
//
//  Created by 엄승주 on 12/3/23.
//

import UIKit //button, textinput...

//                      inheritance ->
class ViewController: UIViewController {
    
    @IBOutlet private weak var display: UILabel! //optional
    
    //숩자 버튼 입력중인지 체크하는 변수
    private var userIsInTheMiddleOfTyping  = false
    
    //숫자 버튼 클릭
    // func 함수명        arguments type
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping{
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }
        else{
            display.text=digit
        }
        userIsInTheMiddleOfTyping=true
    }
    
    //표시되는 숫자
    private var displayValue: Double { //
        get{ //현재 쓰여진 숫자를 가져옴
            return Double(display.text!)!
        }
        set{ //설정되면 화면에 숫자를 바꿈
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathMaticalSymbol = sender.currentTitle{
            brain.performOperation(symbol: mathMaticalSymbol)
        }
        
        displayValue=brain.result
    }
    
    
}

