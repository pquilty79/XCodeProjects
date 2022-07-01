//
//  ExpenseView.swift
//  iExpense
//
//  Created by Patrick Quilty on 7/1/22.
//

import SwiftUI

struct ExpenseView: View {
    let expense: ExpenseItem

    var body: some View {
        Image(uiImage: expense.receipt.getImage() ?? #imageLiteral(resourceName: "CodeUpCertificate.png"))
            .resizable()
            .scaledToFit()
    }
}

//struct ExpenseView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        ExpenseView(expense: ExpenseItem(from: <#Decoder#>))
//    }
//}
