//
//  ContentView.swift
//  BetterRest
//
//  Created by Patrick Quilty on 6/25/22.
//
import CoreML
import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    @State private var coffeeAmount = 1
    
    var body: some View {
        NavigationView {
            VStack {
                Text("When do you want to wake up?").font(.headline)
                DatePicker("Enter a time", selection:$wakeUp, displayedComponents: .hourAndMinute).labelsHidden().padding()
                Text("Desired amount of sleep").font(.headline)
                Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...10, step: 0.25).padding()
                Text("Daily coffee intake").font(.headline)
                Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value:$coffeeAmount, in: 1...20).padding()
                Spacer()
            }
            .navigationTitle("Better Rest")
            .toolbar {
                Button("Calculate", action: calculateBedtime)
            }
        }
    }
    
    func calculateBedtime() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
