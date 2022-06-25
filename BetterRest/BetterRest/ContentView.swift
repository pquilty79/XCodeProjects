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
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 6
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    VStack (alignment: .leading, spacing: 0) {
                        Text("When do you want to wake up?").font(.headline)
                        DatePicker("Enter a time", selection:$wakeUp, displayedComponents: .hourAndMinute).labelsHidden().padding(.vertical)
                    }
                    VStack (alignment: .leading, spacing: 0) {
                        Text("Desired amount of sleep").font(.headline)
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...10, step: 0.25).padding(.vertical)
                    }
                    VStack (alignment: .leading, spacing: 0) {
                        Text("Daily coffee intake").font(.headline)
                        Picker("Select", selection: $coffeeAmount) {
                            ForEach(1..<21) {
                                Text("\($0) cups")
                            }.padding()
                        }
                    }
                        .alert(alertTitle, isPresented: $showingAlert) {
                            Button("Okay") {}
                        } message: {
                            Text(alertMessage)
                        }
                }
                .navigationTitle("Better Rest")
                .toolbar {
                    Button("Calculate", action: calculateBedtime)
            }
//                VStack (alignment: .center, spacing: 0) {
//                    Text(alertTitle).font(.headline)
//                    Text(alertMessage).font(.headline)
//                }
            }
        }
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "Your ideal bedtime is:"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
