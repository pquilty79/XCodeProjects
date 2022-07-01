//
//  ContentView.swift
//  MathWiz
//
//  Created by Patrick Quilty on 7/1/22.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var numberOne = 0.0
    @State private var numberTwo = 0.0
    @State private var chosenOperand = "plus"
    @State private var displayedOperand = "+"
    @State private var milaAnswer = ""
    @State private var correctAnswer = 0.0
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    @State private var plusAnimation = 1.0
    @State private var minusAnimation = 1.0
    @State private var multiplyAnimation = 1.0
    @State private var divideAnimation = 1.0
    @State private var numberCorrect = 0
    @State private var numberOfQuestion = 0
    
    var body: some View {
        VStack {
            Image(uiImage: #imageLiteral(resourceName: "horse.png"))
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            Text("Hello, Mila! What kind of math do you want to practice today?")
                .fontWeight(.bold)
                .font(.system(size: 20))
                .padding()
                .multilineTextAlignment(.center)
            HStack{
                Button {
                    if plusAnimation == 1.0 {
                        plusAnimation += 0.5
                    }
                   minusAnimation = 1.0
                   multiplyAnimation = 1.0
                   divideAnimation = 1.0
                   chosenOperand = "plus"
                   chooseOperand(chosenOperand: chosenOperand)
                } label: {
                    Image(systemName: "plus.square.fill").resizable()
                        .frame(width: 50, height: 50)
                        .padding(.horizontal)
                        .foregroundColor(.cyan)
                }
                .scaleEffect(plusAnimation)
                .animation(.default, value: plusAnimation)
                Button {
                    if minusAnimation == 1.0 {
                        minusAnimation += 0.5
                    }
                    plusAnimation = 1.0
                    multiplyAnimation = 1.0
                    divideAnimation = 1.0
                    chosenOperand = "minus"
                    chooseOperand(chosenOperand: chosenOperand)
                } label: {
                    Image(systemName: "minus.square.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.horizontal)
                        .foregroundColor(.pink)
                }
                .scaleEffect(minusAnimation)
                .animation(.default, value: minusAnimation)
                Button {
                    if multiplyAnimation == 1.0 {
                        multiplyAnimation += 0.5
                    }
                    plusAnimation = 1.0
                    minusAnimation = 1.0
                    divideAnimation = 1.0
                    chosenOperand = "multiply"
                    chooseOperand(chosenOperand: chosenOperand)
                } label: {
                    Image(systemName: "multiply.square.fill").resizable()
                        .frame(width: 50, height: 50)
                        .padding(.horizontal)
                        .foregroundColor(.purple)
                }
                .scaleEffect(multiplyAnimation)
                .animation(.default, value: multiplyAnimation)
                Button {
                    if divideAnimation == 1.0 {
                        divideAnimation += 0.5
                    }
                    plusAnimation = 1.0
                    minusAnimation = 1.0
                    multiplyAnimation = 1.0
                    chosenOperand = "divide"
                    chooseOperand(chosenOperand: chosenOperand)
                } label: {
                    Image(systemName: "divide.square.fill").resizable()
                        .frame(width: 50, height: 50)
                        .padding(.horizontal)
                        .foregroundColor(.green)
                }
                .scaleEffect(divideAnimation)
                .animation(.default, value:divideAnimation)
            }
            HStack {
                Text("n = ")
                    .font(.system(size: 75))
                Text(String(Int(numberOne)))
                    .font(.system(size: 75))
                Text(displayedOperand)
                    .font(.system(size: 75))
                Text(String(Int(numberTwo)))
                    .font(.system(size: 75))
            }
            TextField("Answer", text: $milaAnswer)
                    .font(Font.system(size: 60, design: .default))
                    .keyboardType(.numberPad)
                    .onReceive(Just(milaAnswer)) { newValue in
                        let filtered = newValue.filter { "0123456789.-".contains($0) }
                        if filtered != newValue {
                            self.milaAnswer = filtered
                        }
                    }
                    .multilineTextAlignment(.center)
            Button {
                checkAnswer(milasAnswer: milaAnswer)
            } label: {
                Text("Submit")
                    .frame(minWidth: 0, maxWidth: 200)
                    .padding()
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: 25).fill(Color.red))
                    }
            Text("\(numberCorrect) out of \(numberOfQuestion) Correct!")
                .font(.system(size: 25))
            Button {
            chooseOperand(chosenOperand: chosenOperand)
                } label: {
             Image(systemName: "play.square.fill").resizable()
                 .frame(width: 50, height: 50)
                 .foregroundColor(.green)
                }
                }
        .alert(alertTitle, isPresented: $showingAlert) {
                Button("Okay", role: .cancel) {
                    milaAnswer = ""
                }
    } message: {
        Text(alertMessage)
        }
    }
    func chooseOperand(chosenOperand: String) {
        let firstNumber = round(Double.random(in: 0..<79))
        let secondNumber = round(Double.random(in: 0..<79))
        numberOfQuestion += 1
        if firstNumber >= secondNumber {
            numberOne = firstNumber
            numberTwo = secondNumber
        } else {
            numberOne = secondNumber
            numberTwo = firstNumber
        }
        if chosenOperand == "plus" {
            displayedOperand = "+"
            correctAnswer = numberOne + numberTwo
        }
        if chosenOperand == "minus" {
            displayedOperand = "-"
            correctAnswer = numberOne - numberTwo
        }
        if chosenOperand == "multiply" {
            displayedOperand = "x"
            correctAnswer = numberOne * numberTwo
        }
        if chosenOperand == "divide" {
            displayedOperand = "/"
            correctAnswer = numberOne / numberTwo
        }
    }
    func checkAnswer(milasAnswer: String) {
        if Double(milasAnswer) == correctAnswer {
            alertTitle = "Correct!"
            alertMessage = "Pistol neighs in joy at your answer"
            numberCorrect += 1
            showingAlert = true
            Sounds.playSounds(soundfile: "Horse-Neigh-Quick-B-www.fesliyanstudios.com.mp3")
        } else {
            alertTitle = "Try again"
            alertMessage = "The correct is \(correctAnswer)"
            showingAlert = true
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
