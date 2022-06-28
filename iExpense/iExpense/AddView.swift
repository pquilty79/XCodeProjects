//
//  AddView.swift
//  iExpense
//
//  Created by Patrick Quilty on 6/27/22.
//

import SwiftUI
import VisionKit

struct AddView: View {
    @State private var name = ""
    @State private var location = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss
    @State private var showScanner = false
    @State private var scannedImages = UIImage()
    
    let types = ["Business", "Personal"]

    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Name", text: $name)
                    TextField("Location", text: $location)
                    Picker("Type", selection: $type) {
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                    }
                    TextField("Amount", value: $amount, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad)
                        .navigationTitle("Add new expense")
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                    Button("Cancel") {
                                        dismiss()
                                }
                            }
                            ToolbarItem(placement: .navigationBarTrailing) {
                                    Button("Save") {
                                        let item = ExpenseItem(name: name, type: type, location: location, amount: amount, receipt: Receipt(withImage:scannedImages))
                                        expenses.items.append(item)
                                        dismiss()
                                    }
                                }
                            }
                        }
                Image(uiImage: scannedImages)
                Button {
                    showScanner = true
                } label: {
                    Text("Scan Receipt")
                    Image(systemName: "camera")
                    }
                }
            }
        .sheet(isPresented: $showScanner, content: {
            ScannerView { result in
                switch result {
                case .success(let scannedPages):
                    scannedImages = scannedPages[0]
                case .failure(let error):
                        print(error.localizedDescription)
                }
                
                showScanner = false
                
            } didCancelScanning: {
                showScanner = false
            }
        })
        }
    }

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
