//
//  BlendView.swift
//  Drawing
//
//  Created by Patrick Quilty on 7/1/22.
//

import SwiftUI

struct BlendView: View {
    @State private var amount = 0.0
    
    var body: some View {
        ZStack {
            Image(uiImage: #imageLiteral(resourceName: "patrick.quilty.jpg"))
                .resizable()
                .scaledToFit()
//                .colorMultiply(.red)
                .saturation(amount)
//                .blur(radius: (1 - amount) * 10)
      }
        .frame(width: 400, height: 500)
        .clipped()
    }
}

struct BlendView_Previews: PreviewProvider {
    static var previews: some View {
        BlendView()
    }
}
