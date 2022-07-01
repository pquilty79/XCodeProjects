//
//  RectangleView.swift
//  Drawing
//
//  Created by Patrick Quilty on 7/1/22.
//

import SwiftUI

struct RectangleView: View {
    @State private var colorCycle = 0.0
    @State private var gradientStartX = 0.5
    @State private var gradientStartY = 0.0
    @State private var gradientEndX = 0.5
    @State private var gradientEndY = 0.5

    var body: some View {
        VStack {
            ColorCyclingRectangle(amount: colorCycle, gradientStartX: gradientStartX, gradientStartY: gradientStartY, gradientEndX: gradientEndX, gradientEndY: gradientEndY)
                .frame(width: 300, height: 300)

            HStack {
                Text("Start X")
                Slider(value: $gradientStartX)
            }

            HStack {
                Text("Start Y")
                Slider(value: $gradientStartY)
            }

            HStack {
                Text("End X")
                Slider(value: $gradientEndX)
            }

            HStack {
                Text("End Y")
                Slider(value: $gradientEndY)
            }
        }
    }
}

struct RectangleView_Previews: PreviewProvider {
    static var previews: some View {
        RectangleView()
    }
}
