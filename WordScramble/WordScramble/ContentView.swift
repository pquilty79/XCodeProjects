//
//  ContentView.swift
//  WordScramble
//
//  Created by Patrick Quilty on 6/25/22.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var numberOfAttempts = 0
    
    var body: some View {
        NavigationView {
                VStack {
                    List {
                        Section {
                            TextField("Enter your word", text: $newWord)
                                .autocapitalization(.none)
                            Text("Matching guessses : \(usedWords.count)")
                            Text("Incorrect attempts: \(numberOfAttempts)")
                        }
                        Section {
                            ForEach(usedWords, id: \.self) { word in
                                HStack {
                                    Image(systemName: "\(word.count).circle")
                                    Text(word)
                                }
                            }
                        }
                    }.listStyle(InsetGroupedListStyle())
                    Button {
                        startGame()
                    } label: {
                       Text("New Word")
                    }
                    .padding(.top)
            }
                .buttonStyle(.borderedProminent)
                .navigationTitle(rootWord)
                .onSubmit(addNewWord)
                .onAppear(perform: startGame)
                .alert(errorTitle, isPresented: $showingError) {
                        Button("Okay", role: .cancel) {}
            } message: {
                Text(errorMessage)
                }
            }
        }
    
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        if numberOfAttempts < 5 {
            guard isAtLeastThreeLetters(word: answer) else {
                wordError(title: "Length error", message: "Accepted words must be 2 or more letters")
                numberOfAttempts += 1
                return
            }
            guard isOriginal(word: answer) else {
                wordError(title: "Word used already", message: "Be more original")
                numberOfAttempts += 1
                return
            }
            guard isPossible(word: answer) else {
                wordError(title: "Word not possible", message: "You cannot spell that words from '\(rootWord)'")
                numberOfAttempts += 1
                return
            }
            guard isReal(word: answer) else {
                wordError(title: "Word not recognized", message: "This is not a real word")
                numberOfAttempts += 1
                return
            }
            guard isNotSameWord(word: answer) else {
                wordError(title: "Error", message: "Answer cannot be original word")
                numberOfAttempts += 1
                return
            }
            withAnimation {
                usedWords.insert(answer, at: 0)
            }
            newWord = ""
        } else {
            wordError(title: "You lose", message: "Better luck next time")
        }
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String (contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                numberOfAttempts = 0
                usedWords.removeAll()
                return
            }
        }
        fatalError("Could not load start.txt from bundle")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isAtLeastThreeLetters(word: String) -> Bool {
        word.count > 3
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        for letter in word {
            if let possible = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: possible)
            } else {
                return false
            }
        }
        return true
    }
    
    func isNotSameWord(word: String) -> Bool {
        if word == rootWord {
            return false
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
