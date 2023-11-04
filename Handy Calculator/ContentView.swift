//
//  ContentView.swift
//  Handy Calculator
//
//  Created by Burak Cebecioğlu on 02/11/2023.
//

import SwiftUI

struct ContentView: View {
    // To hold final value of the evaluated expression
    @State var result: Double = 0
    @State var tempResult: Double = 0
    @State var resultToShow: Double = 0
    @State var currentOperation: String = ""
    
    var body: some View {
        VStack {
            VStack {
                Text(buildResultStringToView())
            }
            VStack {
                HStack{
                    buildFunctionButton(buttonTap: "C")
                    buildFunctionButton(buttonTap: "+/-")
                    buildFunctionButton(buttonTap: "%")
                    buildFunctionButton(buttonTap: "/")
                }
                HStack{
                    buildButton(buttonTap: 7)
                    buildButton(buttonTap: 8)
                    buildButton(buttonTap: 9)
                    buildFunctionButton(buttonTap: "*")
                }
                HStack{
                    buildButton(buttonTap: 4)
                    buildButton(buttonTap: 5)
                    buildButton(buttonTap: 6)
                    buildFunctionButton(buttonTap: "-")
                }
                HStack{
                    buildButton(buttonTap: 1)
                    buildButton(buttonTap: 2)
                    buildButton(buttonTap: 3)
                    buildFunctionButton(buttonTap: "+")
                    }
                }
                HStack{
                    buildButton(buttonTap: 0)
                    buildFunctionButton(buttonTap: ".")
                    buildFunctionButton(buttonTap: "=")
                }
                
            }
            .buttonStyle(.bordered)
        }
    
    func buildResultStringToView() -> String {
        let doubleResult = self.resultToShow
        var stringResult: String = ""
        
        if doubleResult > doubleResult.rounded(.towardZero) {
            stringResult = String(doubleResult)
        } else {
            stringResult = String(Int(doubleResult))
        }
        return stringResult
    }
    
    func buildButton(buttonTap: Double) -> some View {
        return Button(action: {
            self.result = (self.result * 10) + buttonTap
            self.resultToShow = self.result
        }) {
            Text(String(Int(buttonTap)))
        }
    }
    
    func buildFunctionButton(buttonTap: String) -> some View {
        return Button(action: {
            switch buttonTap {
            case "C":
                self.resultToShow = 0.0
                self.result = 0.0
                self.tempResult = 0.0
                self.currentOperation = ""
            case "+/-":
                self.result *= -1.0
                self.tempResult = 0.0
                self.currentOperation = ""
            case "%":
                self.result /= 100
                self.tempResult = 0.0
                self.currentOperation = ""
            case "+", "-", "*", "/":
                calculate()
                operationUpdate(buttonTap)
            case "=":
                calculate()
            default:
                self.result = self.result
            }
        }) {
            Text(buttonTap)
        }
    }
    
    func operationUpdate(_ buttonTap: String) {
        self.tempResult = self.result
        self.result = 0.0
        self.currentOperation = buttonTap
    }
    
    func calculate() {
        switch self.currentOperation {
        case "+":
            self.result += self.tempResult
        case "-":
            self.result = self.tempResult - self.result
        case "*":
            self.result *= self.tempResult
        case "/":
            self.result = self.tempResult / self.result
        default:
            self.result = self.result
        }
        self.currentOperation = ""
        self.resultToShow = self.result
        self.tempResult = 0.0
    }
}

#Preview {
    ContentView()
}
