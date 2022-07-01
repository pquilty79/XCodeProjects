//
//  ExpenseView.swift
//  iExpense
//
//  Created by Patrick Quilty on 7/1/22.
//

import SwiftUI
import MessageUI

struct ExpenseView: View {
    let expense: ExpenseItem
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                VStack {
                    Text("\(expense.name) - \(expense.location)").font(.headline)
                    Text(expense.type)
                }
                Spacer()
                Text(expense.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                    }
                Image(uiImage: expense.receipt.getImage() ?? #imageLiteral(resourceName: "CodeUpCertificate.png"))
                    .resizable()
                .scaledToFit()
                Spacer()
            }
        }
        .toolbar {
            Button {
                self.isShowingMailView.toggle()
            } label: {
                Image(systemName: "mail")
            }
            .disabled(!MFMailComposeViewController.canSendMail())
            .sheet(isPresented: $isShowingMailView) {
                MailView(result: self.$result)
            }
        }
    }
}

//struct ExpenseView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        ExpenseView(expense: ExpenseItem(from: <#Decoder#>))
//    }
//}
