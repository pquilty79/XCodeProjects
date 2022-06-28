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
    let receipt: Receipt
}

struct Receipt: Codable{
    let imageData: Data?
    
    init(withImage image: UIImage) {
        self.imageData = image.pngData()
    }

    func getImage() -> UIImage? {
        guard let imageData = self.imageData else {
            return nil
        }
        let image = UIImage(data: imageData)
        
        return image
    }
}
