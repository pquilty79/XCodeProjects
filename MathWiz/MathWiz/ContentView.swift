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
    @AppStorage ("numberCorrect") var numberCorrect = 0
    @AppStorage("numberOfQuestion") private var numberOfQuestion = 1
    @AppStorage("level") private var levelNumber = 1
    @State private var previousNumber = 0.0
    @State private var previousSecondNumber = 0.0
    @AppStorage("score") private var score = 0
    @AppStorage("highScore") private var highScore = 0
    
    
    init(){
        UITableView.appearance().backgroundColor = .clear
        UITableView.appearance().separatorColor = .white
    }
    
    var body: some View {
            ScrollView {
                Text("Level \(levelNumber)").font(.system(size: 20)).bold().foregroundColor(.white).padding(.top)
                Text("Question \(numberOfQuestion) of 9").font(.system(size: 18)).foregroundColor(.white)
                Image(uiImage: #imageLiteral(resourceName: "horse.png"))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
                HStack {
                    Spacer()
                    Text("Current Score: \(score)")
                        .font(.system(size: 18)).foregroundColor(.white)
                    Spacer()
                    Text("High Score: \(highScore)")
                        .font(.system(size: 18)).foregroundColor(.white)
                    Spacer()
                }.padding(.horizontal)
                Text("Pick a problem type:")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                HStack{
                    Button {
                        if plusAnimation == 1.0 {
                            plusAnimation += 0.25
                        }
                       minusAnimation = 1.0
                       multiplyAnimation = 1.0
                       divideAnimation = 1.0
                       chosenOperand = "plus"
                       chooseOperand(chosenOperand: chosenOperand)
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 45, height: 45)
                            .padding(.horizontal)
                            .foregroundColor(.teal)
                            .shadow(color: .gray, radius: 2, x: 0, y: 2)
                    }
                    .scaleEffect(plusAnimation)
                    .animation(.default, value: plusAnimation)
                    Button {
                        if minusAnimation == 1.0 {
                            minusAnimation += 0.25
                        }
                        plusAnimation = 1.0
                        multiplyAnimation = 1.0
                        divideAnimation = 1.0
                        chosenOperand = "minus"
                        chooseOperand(chosenOperand: chosenOperand)
                    } label: {
                        Image(systemName: "minus.circle.fill")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 45, height: 45)
                            .padding(.horizontal)
                            .foregroundColor(.pink)
                            .shadow(color: .gray, radius: 2, x: 0, y: 2)
                    }
                    .scaleEffect(minusAnimation)
                    .animation(.default, value: minusAnimation)
                    Button {
                        if multiplyAnimation == 1.0 {
                            multiplyAnimation += 0.25
                        }
                        plusAnimation = 1.0
                        minusAnimation = 1.0
                        divideAnimation = 1.0
                        chosenOperand = "multiply"
                        chooseOperand(chosenOperand: chosenOperand)
                    } label: {
                        
                        Image(systemName: "multiply.circle.fill")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 45, height: 45)
                            .padding(.horizontal)
                            .foregroundColor(.purple)
                            .shadow(color: .gray, radius: 2, x: 0, y: 2)
                    }
                    .scaleEffect(multiplyAnimation)
                    .animation(.default, value: multiplyAnimation)
                    Button {
                        if divideAnimation == 1.0 {
                            divideAnimation += 0.25
                        }
                        plusAnimation = 1.0
                        minusAnimation = 1.0
                        multiplyAnimation = 1.0
                        chosenOperand = "divide"
                        chooseOperand(chosenOperand: chosenOperand)
                    } label: {
                        Image(systemName: "divide.circle.fill")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 45, height: 45)
                            .padding(.horizontal)
                            .foregroundColor(.orange)
                            .shadow(color: .gray, radius: 2, x: 0, y: 2)
                    }
                    .scaleEffect(divideAnimation)
                    .animation(.default, value:divideAnimation)
                }
                Form {
                    HStack {
                        Spacer()
                        Text(String(Int(numberOne)))
                            .font(.system(size: 40)).foregroundColor(.white)
                        Text(displayedOperand)
                            .font(.system(size: 40)).foregroundColor(.white)
                        Text(String(Int(numberTwo)))
                            .font(.system(size: 40)).foregroundColor(.white)
                        Text("=")
                            .font(.system(size: 40)).foregroundColor(.white)
                        Spacer()
                    }.listRowBackground(Color.blue.opacity(0.075))
                    TextField("Answer", text: $milaAnswer)
                        .keyboardType(.numbersAndPunctuation)
                        .font(.system(size: 40, design: .default)).foregroundColor(.white)
                            .onReceive(Just(milaAnswer)) { newValue in
                                let filtered = newValue.filter { "0123456789.-".contains($0) }
                                if filtered != newValue {
                                    self.milaAnswer = filtered
                                }
                            }
                        .listRowBackground(Color.blue.opacity(0.075))
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                }
                .frame(height: 160)
                Button {
                    checkAnswer(milasAnswer: milaAnswer)
                } label: {
                    Text("Submit")
                        .frame(minWidth: 0, maxWidth: 200)
                        .padding()
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 25).fill(Color.red))
                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                        }
                .padding(.bottom)
                HStack {
                    Spacer()
                    Button {
                    chooseOperand(chosenOperand: chosenOperand)
                        numberCorrect = 0
                        numberOfQuestion = 1
                        levelNumber = 1
                        score = 0
                        alertTitle = "Level \(levelNumber)"
                        alertMessage = "Let's start simple and work our way up."
                        showingAlert = true
                        } label: {
                            VStack {
                                Image(systemName: "arrowtriangle.up.circle.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.blue).shadow(color: .gray, radius: 2, x: 0, y: 2)
                                Text("Start Over")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                }
                    }
                    Spacer()
                    Button {
                    chooseOperand(chosenOperand: chosenOperand)
                        } label: {
                            VStack {
                                Image(systemName: "play.circle.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(.green)
                                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
                                Text("Skip Question")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                }
                    }
                    Spacer()
                }
                    }
            .alert(alertTitle, isPresented: $showingAlert) {
                    Button("Okay", role: .cancel) {
                        milaAnswer = ""
                    }
        } message: {
            Text(alertMessage)
            }
    .background(.cyan)
        }
    
    
    func chooseOperand(chosenOperand: String) {
        previousNumber = numberOne
        previousSecondNumber = numberTwo
        var firstNumber = round(Double.random(in: 0..<9) * Double(levelNumber))
        var secondNumber = round(Double.random(in: 0..<9) * Double(levelNumber))
        while firstNumber == previousNumber {
            firstNumber = round(Double.random(in: 0..<9) * Double(levelNumber))
        }
        while secondNumber == previousSecondNumber {
            secondNumber = round(Double.random(in: 0..<9) * Double(levelNumber))
        }
        if secondNumber > firstNumber  {
            numberTwo = firstNumber
            numberOne = secondNumber
        } else {
            numberOne = firstNumber
            numberTwo = secondNumber
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
            if numberTwo != 0 {
                correctAnswer = round(numberOne / numberTwo * 100) / 100.0
            } else {
                chooseOperand(chosenOperand: chosenOperand)
            }
        }
    }
    
    func checkAnswer(milasAnswer: String) {
        if Double(milasAnswer) == correctAnswer {
            alertTitle = "Correct!"
            alertMessage = "Horsey neighs in joy at your answer"
            numberCorrect += 1
            score += (levelNumber * 10)
            if score > highScore {
                highScore = score
            }
            showingAlert = true
            Sounds.playSounds(soundfile: "Horse-Neigh-Quick-B-www.fesliyanstudios.com.mp3")
            if numberOfQuestion < 10 {
                chooseOperand(chosenOperand: chosenOperand)
                numberOfQuestion += 1
            }
        } else {
            alertTitle = "Try again"
            alertMessage = "That is not quite right."
            showingAlert = true
            Sounds.playSounds(soundfile: "Nope-sound-effect.mp3")
            if numberOfQuestion < 10 {
                numberOfQuestion += 1
            }
        }
        if numberOfQuestion == 10 && numberCorrect >= 7 {
            levelNumber += 1
            alertTitle = "Level \(levelNumber)"
            alertMessage = "Great job! Let's try some slightly harder problems."
            showingAlert = true
            numberOfQuestion = 1
            numberCorrect = 0
            Sounds.playSounds(soundfile: "Quiz-correct-sound-with-applause.mp3")
            chooseOperand(chosenOperand: chosenOperand)
        } else if numberOfQuestion == 10 && numberCorrect < 7 {
            alertTitle = "Game Over"
            alertMessage = "You must get 7 or more correct per round to proceed. Try again soon!"
            showingAlert = true
            numberOfQuestion = 1
            numberCorrect = 0
            levelNumber = 1
            score = 0
            Sounds.playSounds(soundfile: "You-lose-sound-effect.mp3")
            chooseOperand(chosenOperand: chosenOperand)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
