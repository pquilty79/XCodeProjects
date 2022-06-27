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
//    @State private var receipt: UIImage

    
    let types = ["Business", "Personal"]
//    let vc = VNDocumentCameraViewController()
    
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
                                        let item = ExpenseItem(name: name, type: type, location: location, amount: amount)
                                        expenses.items.append(item)
                                        dismiss()
                                    }
                                }
                            }
                        }
                Button {

                } label: {
                    Text("Scan Receipt")
                    Image(systemName: "camera")
                    }
                }
            }
        }
    }

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
