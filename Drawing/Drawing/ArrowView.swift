//
//  ArrowView.swift
//  Drawing
//
//  Created by Patrick Quilty on 7/1/22.
//

import SwiftUI

struct ArrowView: View {
    @State private var headHeight = 0.5
    @State private var shaftWidth = 0.25

    var body: some View {
        Arrow(headHeight: headHeight, shaftWidth: shaftWidth)
            .fill(.blue)
            .onTapGesture {
                withAnimation {
                    headHeight = Double.random(in: 0.2...0.8)
                    shaftWidth = Double.random(in: 0.2...0.8)
                }
            }
    }
}

struct ArrowView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowView()
    }
}
