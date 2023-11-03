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
    @State var currentOperation: String = ""
    
    var body: some View {
        VStack {
            VStack {
                Text(String(self.result))
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
    
    func buildButton(buttonTap: Double) -> some View {
        var tempResult = self.result
        return Button(action: {
            tempResult = (tempResult * 10) + buttonTap
            self.result = tempResult
        }) {
            Text(String(Int(buttonTap)))
        }
    }
    
    func buildFunctionButton(buttonTap: String) -> some View {
        return Button(action: {
            switch buttonTap {
            case "C":
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
            case "+":
                operationUpdate(buttonTap)
            case "-":
                operationUpdate(buttonTap)
            case "*":
                operationUpdate(buttonTap)
            case "/":
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
            self.tempResult = 0.0
        case "-":
            self.result -= self.tempResult
            self.tempResult = 0.0
        case "*":
            self.result *= self.tempResult
            self.tempResult = 0.0
        case "/":
            self.result /= self.tempResult
            self.tempResult = 0.0
        default:
            self.result = self.result
        }
    }
}

#Preview {
    ContentView()
}
