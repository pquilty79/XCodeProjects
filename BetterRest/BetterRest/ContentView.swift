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
    @State private var alertMessage = "Something"
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 6
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    init(){
        UITableView.appearance().backgroundColor = .clear
        Theme.navigationBarColors(background: .clear, titleColor: .white)
    }
    
    var idealBedTime: String {
        var bedtime = ""
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            bedtime = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            bedtime = "Sorry, there was a problem calculating your bedtime."
        }
        return bedtime
    }
    
    var body: some View {
        NavigationView {
        ZStack {
            Color.indigo.ignoresSafeArea()
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
                    }
                    .padding(.top)
                    VStack {
                        Text("Your ideal bedtime is").font(.headline)
                        Text(idealBedTime).font(.largeTitle.weight(.semibold))
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .padding(.top, 50)
                }
                .navigationTitle("Better Rest")
                }
            }
        }
    class Theme {
        static func navigationBarColors(background : UIColor?,
           titleColor : UIColor? = nil, tintColor : UIColor? = nil ){
            
            let navigationAppearance = UINavigationBarAppearance()
            navigationAppearance.configureWithOpaqueBackground()
            navigationAppearance.backgroundColor = background ?? .clear
            
            navigationAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .black]
            navigationAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .black]
           
            UINavigationBar.appearance().standardAppearance = navigationAppearance
            UINavigationBar.appearance().compactAppearance = navigationAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance

            UINavigationBar.appearance().tintColor = tintColor ?? titleColor ?? .black
        }
    }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
