//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Patrick Quilty on 6/24/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var questionsAnswered = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.cyan, .black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                    .padding(.top)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.white)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                        ForEach(0..<4) { number in
                            Button {
                                flagTapped(number)
                            } label: {
                                Image(countries[number])
                                    .renderingMode(.original)
                                    .shadow(radius: 5)
                            }
                        }
                    }
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Button {
                    resetGame()
                    } label: {
                        Text("Reset")
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.borderedProminent)
                    .background(.ultraThinMaterial)
                    .clipShape(Capsule())
                    .shadow(radius: 5)
                }

            }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
            }
        }
    
        func flagTapped(_ number: Int) {
            if number == correctAnswer {
                scoreTitle = "Correct"
                score += 1
                questionsAnswered += 1
            } else {
                scoreTitle = "Wrong"
                questionsAnswered += 1
            }
            showingScore = true
        }
    
        func askQuestion() {
                countries.shuffle()
                correctAnswer = Int.random(in: 0...2)
        }
        func resetGame() {
            score = 0
            questionsAnswered = 0
            countries.shuffle()
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
