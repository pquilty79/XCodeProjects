//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Patrick Quilty on 6/27/22.
//

import Foundation
import UIKit

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let location: String
    let amount: Double
}
